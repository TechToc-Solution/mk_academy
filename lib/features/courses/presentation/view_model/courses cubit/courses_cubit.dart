import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/courses/data/model/courses_model.dart';
import 'package:mk_academy/features/courses/data/repo/courses_repo.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit(this._coursesRepo) : super(CoursesState());
  final CoursesRepo _coursesRepo;
  Future<void> getCourses(
      {required int? courseTypeId,
      required int subjectId,
      String? search,
      bool loadMore = false}) async {
    if (state.hasReachedMax || isClosed) return;
    if (!loadMore) resetPagination();

    var data = await _coursesRepo.getCourses(
        courseTypeId: courseTypeId,
        subjectId: subjectId,
        page: state.currentPage + 1);
    if (!isClosed) {
      data.fold(
          (failure) => emit(state.copyWith(
                status: CoursesStatus.failure,
                errorMessage: failure.message,
              )), (coursesData) {
        final newCourses = [
          ...state.courses,
          ...coursesData.courses!,
        ];
        emit(state.copyWith(
          courses: newCourses,
          currentPage: coursesData.currentPage,
          status: CoursesStatus.success,
          hasReachedMax: !coursesData.hasNext!,
        ));
      });
    }
  }

  void resetPagination() {
    emit(const CoursesState());
  }
}
