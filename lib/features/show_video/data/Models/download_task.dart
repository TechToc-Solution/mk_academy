// download_task.dart
import 'package:mk_academy/features/courses/data/model/video_model.dart';

class DownloadTask {
  final String taskId;
  final String videoId;
  final DownloadItem quality;
  final int progress;
  final int total;
  final int received;
  final Duration estimatedTime;
  final DownloadStatus status;
  final String? filePath;

  DownloadTask({
    required this.taskId,
    required this.videoId,
    required this.quality,
    this.progress = 0,
    this.total = 0,
    this.received = 0,
    this.estimatedTime = Duration.zero,
    this.status = DownloadStatus.queued,
    this.filePath,
  });

  DownloadTask copyWith({
    int? progress,
    int? total,
    int? received,
    Duration? estimatedTime,
    DownloadStatus? status,
    String? filePath,
  }) {
    return DownloadTask(
      taskId: taskId,
      videoId: videoId,
      quality: quality,
      progress: progress ?? this.progress,
      total: total ?? this.total,
      received: received ?? this.received,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      status: status ?? this.status,
      filePath: filePath ?? this.filePath,
    );
  }
}

enum DownloadStatus {
  queued,
  downloading,
  paused,
  completed,
  failed,
}
