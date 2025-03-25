part of 'subjects_cubit.dart';

sealed class subjectsState extends Equatable {
  const subjectsState();

  @override
  List<Object> get props => [];
}

final class SubjectsInitial extends subjectsState {}

final class getSubjectsSucess extends subjectsState {
  final List<SubjectsData> subjectsData;

  getSubjectsSucess({required this.subjectsData});
}

final class getSubjectsError extends subjectsState {
  final String erroMsg;

  getSubjectsError({required this.erroMsg});
}
