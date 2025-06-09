import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';
import 'package:path_provider/path_provider.dart';

part 'download_manager_state.dart';

/// Tracks whether a download task is just starting, in progress, succeeded, or failed.
enum DownloadStatus { initial, inProgress, success, failure }

/// Represents a single download keyed by "$videoId-$quality".
class DownloadTask extends Equatable {
  final String videoId;
  final String quality;
  bool downloaded;

  /// current status: initial → inProgress → success/failure
  final DownloadStatus status;

  /// percent = (receivedBytes / totalBytes * 100).floor()
  final int progress;

  /// total bytes to download (from HEAD or ranged response)
  final int totalBytes;

  /// bytes downloaded so far (including any previously saved chunk)
  final int receivedBytes;

  /// estimate of time left (optional)
  final Duration estimatedTime;

  /// final local file path, set only when [status] == success
  final String? filePath;

  /// error message, set only when [status] == failure
  final String? error;

  /// so we can cancel if ever needed
  final CancelToken cancelToken;

  DownloadTask(
      {required this.videoId,
      required this.quality,
      required this.status,
      required this.progress,
      required this.totalBytes,
      required this.receivedBytes,
      required this.estimatedTime,
      required this.cancelToken,
      this.filePath,
      this.error,
      this.downloaded = false});

  DownloadTask copyWith({
    DownloadStatus? status,
    int? progress,
    int? totalBytes,
    int? receivedBytes,
    Duration? estimatedTime,
    String? filePath,
    String? error,
    CancelToken? cancelToken,
  }) {
    return DownloadTask(
        videoId: videoId,
        quality: quality,
        status: status ?? this.status,
        progress: progress ?? this.progress,
        totalBytes: totalBytes ?? this.totalBytes,
        receivedBytes: receivedBytes ?? this.receivedBytes,
        estimatedTime: estimatedTime ?? this.estimatedTime,
        cancelToken: cancelToken ?? this.cancelToken,
        filePath: filePath ?? this.filePath,
        error: error ?? this.error,
        downloaded: downloaded);
  }

  @override
  List<Object?> get props => [
        videoId,
        quality,
        status,
        progress,
        totalBytes,
        receivedBytes,
        estimatedTime,
        filePath,
        error,
        downloaded
      ];
}

class DownloadManagerCubit extends Cubit<DownloadManagerState> {
  DownloadManagerCubit() : super(const DownloadManagerState());

  final Dio _dio = Dio();
  final Stopwatch _stopwatch = Stopwatch();

  /// Key used internally to track each download.
  String _keyFor(String videoId, String quality) => '$videoId-$quality';

  /// Public method to start (or resume) a download. If a partial file already exists,
  /// it picks up from where it left off; otherwise it starts from zero.
  Future<void> startDownload(String videoId, DownloadUrls item) async {
    final key = _keyFor(videoId, item.resolution!);

    // If there's already a task in progress or succeeded for this key, do nothing.
    final existing = state.tasks[key];
    if (existing != null) {
      if (existing.status == DownloadStatus.inProgress ||
          existing.status == DownloadStatus.success) {
        return;
      }
      // If it previously failed, we'll restart it below (overwrite).
    }

    // 1) Compute local file path for this (videoId, quality).
    final directory = await getApplicationSupportDirectory();
    final filePath = '${directory.path}/$videoId-${item.resolution}.mp4';
    final tempFile = File(filePath);

    // 2) Determine how many bytes are already downloaded (if any).
    int downloadedBytes = 0;
    if (await tempFile.exists()) {
      downloadedBytes = await tempFile.length();
    }

    // 3) Send a HEAD request to find out total size (in bytes).
    int totalBytes;
    try {
      final headResp = await _dio.head(item.url!);
      totalBytes = int.parse(
        headResp.headers.value(HttpHeaders.contentLengthHeader) ?? '0',
      );
    } catch (e) {
      totalBytes = 0;
    }

    // 4) If we already have the full file, emit success immediately.
    if (downloadedBytes > 0 &&
        totalBytes > 0 &&
        downloadedBytes >= totalBytes) {
      // Only emit success if we know the total size and it's fully downloaded
      final finishedTask = DownloadTask(
          videoId: videoId,
          quality: item.resolution!,
          status: DownloadStatus.success,
          progress: 100,
          totalBytes: totalBytes,
          receivedBytes: downloadedBytes,
          estimatedTime: Duration.zero,
          cancelToken: CancelToken(),
          filePath: filePath,
          error: null,
          downloaded: false);
      final newMap = Map<String, DownloadTask>.from(state.tasks)
        ..[key] = finishedTask;
      emit(state.copyWith(tasks: newMap));
      return;
    }

    // 5) Otherwise, we (re)start download from `downloadedBytes`.
    final cancelToken = CancelToken();
    final initialProgress = totalBytes > 0 && downloadedBytes > 0
        ? ((downloadedBytes / totalBytes) * 100).floor()
        : 0;

    var initialTask = DownloadTask(
        videoId: videoId,
        quality: item.resolution!,
        status: DownloadStatus.inProgress,
        progress: initialProgress,
        totalBytes: totalBytes,
        receivedBytes: downloadedBytes,
        estimatedTime: Duration.zero,
        cancelToken: cancelToken,
        filePath: null,
        error: null,
        downloaded: false);

    // 6) Emit initial inProgress state.
    final updatedMap = Map<String, DownloadTask>.from(state.tasks)
      ..[key] = initialTask;
    emit(state.copyWith(tasks: updatedMap));

    _stopwatch.reset();
    _stopwatch.start();

    // 7) Create an append‐mode IOSink so we write incoming chunks onto the same file.
    IOSink? sink;
    try {
      sink = tempFile.openWrite(mode: FileMode.append);
    } catch (e) {
      // If file open fails, emit failure.
      final failedTask = initialTask.copyWith(
        status: DownloadStatus.failure,
        error: 'Cannot open file for writing: $e',
      );
      final mapAfterFail = Map<String, DownloadTask>.from(state.tasks)
        ..[key] = failedTask;
      emit(state.copyWith(tasks: mapAfterFail));
      return;
    }

    // Keep `seenSoFar` in scope for both the streaming loop and the catch block.
    int seenSoFar = downloadedBytes;
    final total = totalBytes;

    try {
      // 8) Issue a ranged GET request from `downloadedBytes` onwards.
      final response = await _dio.get<ResponseBody>(
        item.url!,
        options: Options(
          responseType: ResponseType.stream,
          headers: {'range': 'bytes=$downloadedBytes-'},
        ),
        cancelToken: cancelToken,
      );

      final stream = response.data!.stream;

      await for (final chunk in stream) {
        // Write chunk to file
        sink.add(chunk);
        seenSoFar += chunk.length;

        // Estimate time remaining
        final elapsedSec = _stopwatch.elapsed.inSeconds;
        Duration estimated = Duration.zero;
        if (elapsedSec > 0 && seenSoFar > 0 && total > 0) {
          final rate = seenSoFar / elapsedSec; // bytes per second
          final secsLeft = ((total - seenSoFar) / rate).round();
          estimated = Duration(seconds: secsLeft);
        }

        final percent =
            total > 0 ? ((seenSoFar / total) * 100).clamp(0, 100).floor() : 0;

        // Emit updated inProgress state
        final updatedTask = initialTask.copyWith(
          progress: percent,
          receivedBytes: seenSoFar,
          totalBytes: total,
          estimatedTime: estimated,
        );
        final newMap2 = Map<String, DownloadTask>.from(state.tasks)
          ..[key] = updatedTask;
        emit(state.copyWith(tasks: newMap2));
      }

      // 9) Once the stream is done, close the sink, stop the stopwatch.
      await sink.flush();
      await sink.close();
      // Save metadata
      await _saveDownloadMetadata(filePath, totalBytes);
      _stopwatch.stop();

      // 10) Emit success state
      final finalTask = initialTask.copyWith(
        status: DownloadStatus.success,
        progress: 100,
        receivedBytes: total,
        filePath: filePath,
      );
      final mapAfterSuccess = Map<String, DownloadTask>.from(state.tasks)
        ..[key] = finalTask;
      emit(state.copyWith(tasks: mapAfterSuccess));
    } catch (e) {
      // In case of any error (including cancel), make sure to close the sink.
      await sink.flush();
      await sink.close();
      _stopwatch.stop();

      final failedTask = initialTask.copyWith(
        status: DownloadStatus.failure,
        error: e.toString(),
        receivedBytes: seenSoFar,
        totalBytes: totalBytes,
      );
      final mapAfterFail2 = Map<String, DownloadTask>.from(state.tasks)
        ..[key] = failedTask;
      emit(state.copyWith(tasks: mapAfterFail2));
    }
  }

  /// Helper to check if a fully‐downloaded file already exists on disk.
  /// Returns the local path if found, otherwise null.
  Future<String?> getDownloadedPath(String videoId, String quality) async {
    final directory = await getApplicationSupportDirectory();
    final filePath = '${directory.path}/$videoId-$quality.mp4';
    final file = File(filePath);
    return (await file.exists()) ? filePath : null;
  }

  Future<void> _saveDownloadMetadata(String filePath, int totalBytes) async {
    final metaFile = File('$filePath.meta');
    await metaFile.writeAsString(totalBytes.toString());
  }

  /// (Optional) If you ever want to cancel a running download:
  void cancelDownload(String videoId, String quality) {
    final key = _keyFor(videoId, quality);
    final task = state.tasks[key];
    if (task != null && task.status == DownloadStatus.inProgress) {
      task.cancelToken.cancel('User requested cancel');
    }
  }

  Future<void> scanExistingDownloads() async {
    final directory = await getApplicationSupportDirectory();
    final files = directory.listSync();

    final Map<String, DownloadTask> existingTasks = {};

    for (var entity in files) {
      if (entity is File && entity.path.endsWith('.mp4')) {
        final fileName = entity.path.split('/').last;
        final parts = fileName.split('-');
        if (parts.length >= 2) {
          final videoId = parts[0];
          final resolution = parts[1].replaceAll('.mp4', '');

          final metaFile = File('${entity.path}.meta');
          if (!await metaFile.exists()) continue;

          final totalBytes = int.tryParse(await metaFile.readAsString());
          final receivedBytes = await entity.length();

          if (totalBytes == null || receivedBytes < totalBytes) continue;

          final key = _keyFor(videoId, resolution);

          existingTasks[key] = DownloadTask(
              videoId: videoId,
              quality: resolution,
              status: DownloadStatus.success,
              progress: 100,
              totalBytes: totalBytes,
              receivedBytes: receivedBytes,
              estimatedTime: Duration.zero,
              cancelToken: CancelToken(),
              filePath: entity.path,
              error: null,
              downloaded: true);
        }
      }
    }

    if (existingTasks.isNotEmpty) {
      emit(state.copyWith(tasks: {...state.tasks, ...existingTasks}));
    }
  }
}
