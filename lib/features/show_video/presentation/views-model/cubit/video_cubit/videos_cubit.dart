import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';
import 'package:mk_academy/features/show_video/data/repo/video_repo.dart';

part 'videos_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideoRepo _videoRepo;
  VideoCubit(this._videoRepo) : super(VideoState());
  Future<VideoDataModel?> getVideo(
      {required int? courseId, required int? videoId}) async {
    if (isClosed) return null;
    var data = await _videoRepo.getVideo(courseId: courseId, videoId: videoId);
    emit(VideoState(
      status: VideoStatus.loading,
    ));
    if (!isClosed) {
      data.fold(
          (failure) => emit(VideoState(
                status: VideoStatus.failure,
                errorMessage: failure.message,
              )), (videosData) {
        emit(VideoState(
          video: videosData,
          status: VideoStatus.success,
        ));
      });
    }
    return null;
  }
}
