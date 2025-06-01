// download_video_cubit.dart
import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:path_provider/path_provider.dart';

part 'download_video_state.dart';

class DownloadVideoCubit extends Cubit<DownloadVideoState> {
  DownloadVideoCubit() : super(const DownloadVideoInitial());

  final Stopwatch _stopwatch = Stopwatch();

  Future<void> downloadVideo(String videoId, DownloadItem item) async {
    emit(const DownloadVideoInProgress(
      progress: 0,
      total: 0,
      received: 0,
      estimatedTime: Duration.zero,
    ));

    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/$videoId-${item.quality}.mp4";

      _stopwatch.reset();
      _stopwatch.start();

      await Dio().download(
        item.url,
        filePath,
        onReceiveProgress: (received, total) {
          final estimated = _estimateTimeRemaining(received, total);
          emit(DownloadVideoInProgress(
            progress: ((received / total) * 100).floor(),
            total: total,
            received: received,
            estimatedTime: estimated,
          ));
        },
      );

      emit(DownloadVideoSuccess(filePath));
    } catch (e) {
      emit(DownloadVideoFailure(e.toString()));
    } finally {
      _stopwatch.stop();
    }
  }

  Duration _estimateTimeRemaining(int received, int total) {
    final elapsed = _stopwatch.elapsed.inSeconds;
    if (elapsed == 0 || received == 0) return Duration.zero;
    final rate = received / elapsed;
    return Duration(seconds: ((total - received) / rate).round());
  }

  Future<bool> checkIfDownloaded(String videoId, String quality) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/$videoId-$quality.mp4";
    return File(filePath).exists();
  }

  Future<String?> getDownloadedPath(String videoId, String quality) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/$videoId-$quality.mp4";
    final file = File(filePath);
    return await file.exists() ? filePath : null;
  }

  Future<List<String>> getDownloadedQualities(
      String videoId, List<DownloadItem> qualities) async {
    final directory = await getApplicationDocumentsDirectory();
    final List<String> downloadedQualities = [];

    for (final item in qualities) {
      final filePath = "${directory.path}/$videoId-${item.quality}.mp4";
      if (await File(filePath).exists()) {
        downloadedQualities.add(item.quality);
      }
    }

    return downloadedQualities;
  }
}
