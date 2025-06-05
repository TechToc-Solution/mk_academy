part of 'videos_cubit.dart';

enum VideoStatus { initial, loading, success, failure }

class VideoState extends Equatable {
  final VideoStatus status;
  final VideoDataModel? video;
  final String? errorMessage;

  const VideoState(
      {this.status = VideoStatus.loading, this.video, this.errorMessage});

  @override
  List<Object?> get props => [status, video, errorMessage];
}
