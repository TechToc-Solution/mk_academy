import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';
import 'package:path_provider/path_provider.dart';

part 'download_manager_state.dart';

/// Tracks whether a download task is just starting, in progress, succeeded, or failed.
enum DownloadStatus { initial, inProgress, paused, success, failure }

/// Represents a single download keyed by "$videoId-$quality".
// ignore: must_be_immutable
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

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
  ));

  final Stopwatch _stopwatch = Stopwatch();

  /// Key used internally to track each download.
  String _keyFor(String videoId, String quality) => '$videoId-$quality';

  /// Public method to start (or resume) a download. If a partial file already exists,
  /// it picks up from where it left off; otherwise it starts from zero.
  Future<void> startDownload(
      String videoId, DownloadUrls item, BuildContext context) async {
    final key = _keyFor(videoId, item.resolution!);
    final existing = state.tasks[key];

    if (existing != null &&
        (existing.status == DownloadStatus.inProgress ||
            existing.status == DownloadStatus.success)) {
      return;
    }

    final directory = await getApplicationSupportDirectory();
    final filePath = '${directory.path}/$videoId-${item.resolution}.mp4';
    final tempFile = File(filePath);
    int downloadedBytes = 0;

    if (await tempFile.exists()) {
      downloadedBytes = await tempFile.length();
    }

    int totalBytes;
    try {
      final headResp = await _dio.head(item.url!,
          options: Options(sendTimeout: Duration(seconds: 5)));
      totalBytes = int.parse(
        headResp.headers.value(HttpHeaders.contentLengthHeader) ?? '0',
      );
    } catch (e) {
      emitFailure('video_error_download'.tr(context), key, videoId, item);
      return;
    }

    if (downloadedBytes > 0 &&
        totalBytes > 0 &&
        downloadedBytes >= totalBytes) {
      emitSuccess(filePath, totalBytes, downloadedBytes, key, videoId, item);
      return;
    }

    final cancelToken = CancelToken();
    final initialProgress =
        totalBytes > 0 ? ((downloadedBytes / totalBytes) * 100).floor() : 0;

    var task = DownloadTask(
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
    );

    emit(state.copyWith(tasks: {...state.tasks, key: task}));
    _stopwatch.reset();
    _stopwatch.start();

    IOSink? sink;
    try {
      sink = tempFile.openWrite(mode: FileMode.append);
    } catch (e) {
      emitFailure('video_error_download'.tr(context), key, videoId, item);
      return;
    }

    int seenSoFar = downloadedBytes;

    try {
      final response = await _dio.get<ResponseBody>(
        item.url!,
        options: Options(
          responseType: ResponseType.stream,
          headers: {'range': 'bytes=$downloadedBytes-'},
          receiveTimeout: Duration(seconds: 15),
        ),
        cancelToken: cancelToken,
      );

      final stream = response.data!.stream.timeout(Duration(seconds: 20),
          onTimeout: (sinkEvent) {
        throw TimeoutException('Download timed out.');
      });

      await for (final chunk in stream) {
        sink.add(chunk);
        seenSoFar += chunk.length;

        final elapsedSec = _stopwatch.elapsed.inSeconds;
        final rate = elapsedSec > 0 ? seenSoFar / elapsedSec : 0;
        final remaining =
            rate > 0 ? ((totalBytes - seenSoFar) / rate).round() : 0;

        final progress = ((seenSoFar / totalBytes) * 100).clamp(0, 100).floor();
        task = task.copyWith(
          progress: progress,
          receivedBytes: seenSoFar,
          estimatedTime: Duration(seconds: remaining),
        );
        emit(state.copyWith(tasks: {...state.tasks, key: task}));
      }

      await sink.flush();
      await sink.close();
      _stopwatch.stop();
      await _saveDownloadMetadata(filePath, totalBytes);

      final successTask = task.copyWith(
        status: DownloadStatus.success,
        progress: 100,
        filePath: filePath,
        receivedBytes: totalBytes,
      );
      emit(state.copyWith(tasks: {...state.tasks, key: successTask}));
    } catch (e) {
      _stopwatch.stop();
      try {
        await sink.flush();
        await sink.close();
      } catch (_) {}

      if (e is DioException && CancelToken.isCancel(e)) return;

      final failedTask = task.copyWith(
        status: DownloadStatus.failure,
        error: e.toString(),
        receivedBytes: seenSoFar,
      );
      emit(state.copyWith(tasks: {...state.tasks, key: failedTask}));
    }
  }

  void emitFailure(
      String errorMsg, String key, String videoId, DownloadUrls item) {
    final failedTask = DownloadTask(
      videoId: videoId,
      quality: item.resolution!,
      status: DownloadStatus.failure,
      progress: 0,
      totalBytes: 0,
      receivedBytes: 0,
      estimatedTime: Duration.zero,
      cancelToken: CancelToken(),
      filePath: null,
      error: errorMsg,
    );
    emit(state.copyWith(tasks: {...state.tasks, key: failedTask}));
  }

  void emitSuccess(String filePath, int total, int received, String key,
      String videoId, DownloadUrls item) {
    final successTask = DownloadTask(
      videoId: videoId,
      quality: item.resolution!,
      status: DownloadStatus.success,
      progress: 100,
      totalBytes: total,
      receivedBytes: received,
      estimatedTime: Duration.zero,
      cancelToken: CancelToken(),
      filePath: filePath,
      downloaded: true,
    );
    emit(state.copyWith(tasks: {...state.tasks, key: successTask}));
  }

  void pauseDownload(String videoId, String quality) {
    final key = _keyFor(videoId, quality);
    final task = state.tasks[key];
    if (task != null && task.status == DownloadStatus.inProgress) {
      // Cancel the HTTP stream
      task.cancelToken.cancel('User paused');
      // Emit paused state
      final pausedTask = task.copyWith(status: DownloadStatus.paused);
      final newMap = Map<String, DownloadTask>.from(state.tasks)
        ..[key] = pausedTask;
      emit(state.copyWith(tasks: newMap));
    }
  }

  /// Cancel and delete any partial file
  void cancelDownload(String videoId, String quality) async {
    final key = _keyFor(videoId, quality);
    final task = state.tasks[key];
    if (task != null &&
        (task.status == DownloadStatus.inProgress ||
            task.status == DownloadStatus.paused)) {
      task.cancelToken.cancel('User cancelled');
    }
    // remove local file
    final dir = await getApplicationSupportDirectory();
    final file = File('${dir.path}/$videoId-$quality.mp4');
    if (await file.exists()) await file.delete();
    // remove metadata
    final newMap = Map<String, DownloadTask>.from(state.tasks)..remove(key);
    emit(state.copyWith(tasks: newMap));
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
