part of 'curriculum_cubit.dart';

sealed class CurriculumState extends Equatable {
  const CurriculumState();

  @override
  List<Object> get props => [];
}

final class CurriculumInitial extends CurriculumState {}

class UnitsLoading extends CurriculumState {}

class UnitsSuccess extends CurriculumState {
  final UnitsModel units;

  const UnitsSuccess({required this.units});
}

class UnitsError extends CurriculumState {
  final String errorMsg;

  const UnitsError({required this.errorMsg});
}
