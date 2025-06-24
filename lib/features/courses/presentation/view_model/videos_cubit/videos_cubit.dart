import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:mk_academy/features/courses/data/repo/courses_repo.dart';

part 'videos_state.dart';

class VideosCubit extends Cubit<VideosState> {
  final CoursesRepo _coursesRepo;
  VideosCubit(this._coursesRepo) : super(VideosState());
  Future<void> getVideos({
    required int? courseId,
  }) async {
    if (isClosed) return;

    emit(VideosState(
      status: VideoStatus.loading,
    ));
    var data = await _coursesRepo.getVideos(
      courseId: courseId,
    );

    if (!isClosed) {
      data.fold(
          (failure) => emit(VideosState(
                status: VideoStatus.failure,
                errorMessage: failure.message,
              )), (videosData) {
        emit(VideosState(
          videos: videosData.videos!,
          status: VideoStatus.success,
        ));
      });
    }
  }
}
