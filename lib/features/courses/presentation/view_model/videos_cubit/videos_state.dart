part of 'videos_cubit.dart';

enum VideoStatus { initial, loading, success, failure }

class VideosState extends Equatable {
  final VideoStatus status;
  final List<Video>? videos;
  final String? errorMessage;

  const VideosState(
      {this.status = VideoStatus.loading, this.videos, this.errorMessage});

  @override
  List<Object?> get props => [status, videos, errorMessage];
}
