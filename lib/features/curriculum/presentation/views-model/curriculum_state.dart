part of 'curriculum_cubit.dart';

sealed class CurriculumState extends Equatable {
  const CurriculumState();

  @override
  List<Object> get props => [];
}

final class CurriculumInitial extends CurriculumState {}

//uints states
class UnitsLoading extends CurriculumState {}

class UnitsSuccess extends CurriculumState {
  final List<Unit> units;

  const UnitsSuccess({required this.units});
}

class UnitsError extends CurriculumState {
  final String errorMsg;

  const UnitsError({required this.errorMsg});
}

// lesson states
class LessonsLoading extends CurriculumState {
  final bool isFirstFetch;

  const LessonsLoading({this.isFirstFetch = true});
}

class LessonsSuccess extends CurriculumState {}

class LessonsError extends CurriculumState {
  final String errorMsg;

  const LessonsError({required this.errorMsg});
}

//lessson details states
class LessonDetailsLoading extends CurriculumState {
  final int lessonId;

  const LessonDetailsLoading({required this.lessonId});

  @override
  List<Object> get props => [lessonId];
}

class LessonDetailsSuccess extends CurriculumState {
  final Lesson lesson;
  const LessonDetailsSuccess({required this.lesson});
}

class LessonDetailsError extends CurriculumState {
  final String errorMsg;
  const LessonDetailsError({
    required this.errorMsg,
  });
}
