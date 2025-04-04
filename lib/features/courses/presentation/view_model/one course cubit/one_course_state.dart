part of 'one_course_cubit.dart';

enum CourseStatus { initial, loading, success, failure }

class OneCourseState extends Equatable {
  final CourseStatus status;
  final Courses? course;
  final String? errorMessage;

  const OneCourseState(
      {this.status = CourseStatus.loading, this.course, this.errorMessage});

  @override
  List<Object?> get props => [status, course, errorMessage];
}
