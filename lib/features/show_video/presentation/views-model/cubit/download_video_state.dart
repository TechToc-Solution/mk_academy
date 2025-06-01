// download_video_state.dart
part of 'download_video_cubit.dart';

abstract class DownloadVideoState extends Equatable {
  const DownloadVideoState();
  @override
  List<Object?> get props => [];
}

class DownloadVideoInitial extends DownloadVideoState {
  const DownloadVideoInitial();
}

class DownloadVideoInProgress extends DownloadVideoState {
  final int progress;
  final int total;
  final int received;
  final Duration estimatedTime;

  const DownloadVideoInProgress({
    required this.progress,
    required this.total,
    required this.received,
    required this.estimatedTime,
  });

  @override
  List<Object?> get props => [progress, total, received, estimatedTime];
}

class DownloadVideoSuccess extends DownloadVideoState {
  final String filePath;
  const DownloadVideoSuccess(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class DownloadVideoFailure extends DownloadVideoState {
  final String error;
  const DownloadVideoFailure(this.error);

  @override
  List<Object?> get props => [error];
}
