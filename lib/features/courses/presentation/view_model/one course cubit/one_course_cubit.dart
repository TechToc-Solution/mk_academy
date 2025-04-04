import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/courses/data/model/courses_model.dart';
import 'package:mk_academy/features/courses/data/repo/courses_repo.dart';

part 'one_course_state.dart';

class OneCourseCubit extends Cubit<OneCourseState> {
  OneCourseCubit(this._coursesRepo) : super(OneCourseState());
  final CoursesRepo _coursesRepo;
  Future<void> getCourse({
    required int? courseId,
  }) async {
    if (isClosed) return;
    var data = await _coursesRepo.getCourse(
      courseId: courseId,
    );
    emit(OneCourseState(
      status: CourseStatus.loading,
    ));
    if (!isClosed) {
      data.fold(
          (failure) => emit(OneCourseState(
                status: CourseStatus.failure,
                errorMessage: failure.message,
              )), (courseData) {
        emit(OneCourseState(
          course: courseData,
          status: CourseStatus.success,
        ));
      });
    }
  }
}
