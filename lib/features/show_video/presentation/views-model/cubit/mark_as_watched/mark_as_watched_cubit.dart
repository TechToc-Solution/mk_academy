import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/show_video/data/repo/video_repo.dart';

part 'mark_as_watched_state.dart';

class MarkAsWatchedCubit extends Cubit<MarkAsWatchedState> {
  final VideoRepo _videoRepo;
  MarkAsWatchedCubit(this._videoRepo) : super(MarkAsWatchedState());

  Future<void> markAsWatched({
    required int courseId,
    required int videoId,
  }) async {
    if (isClosed) return;
    emit(MarkAsWatchedState(
      status: MarkAsWatchedStatus.loading,
    ));
    final data = await _videoRepo.markAsWatched(
      courseId: courseId,
      videoId: videoId,
    );
    data.fold(
      (failure) => emit(MarkAsWatchedState(
        status: MarkAsWatchedStatus.failure,
        errorMessage: failure.message,
      )),
      (success) => emit(MarkAsWatchedState(
        status: MarkAsWatchedStatus.success,
      )),
    );
  }
}
