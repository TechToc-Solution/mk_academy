part of 'curriculum_cubit.dart';

sealed class CurriculumState extends Equatable {
  const CurriculumState();

  @override
  List<Object> get props => [];
}

final class CurriculumInitial extends CurriculumState {}

//uints state
class UnitsLoading extends CurriculumState {}

class UnitsSuccess extends CurriculumState {
  final List<Unit> units;

  const UnitsSuccess({required this.units});
}

class UnitsError extends CurriculumState {
  final String errorMsg;

  const UnitsError({required this.errorMsg});
}

// lesson state
class LessonsLoading extends CurriculumState {
  final bool isFirstFetch;

  const LessonsLoading({this.isFirstFetch = true});
}

class LessonsSuccess extends CurriculumState {
  final List<Lesson> lessons;
  final bool hasReachedMax;
  final int currentPage;

  const LessonsSuccess({
    required this.lessons,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  @override
  List<Object> get props => [lessons, hasReachedMax, currentPage];
}

class LessonsError extends CurriculumState {
  final String errorMsg;

  const LessonsError({required this.errorMsg});
}
