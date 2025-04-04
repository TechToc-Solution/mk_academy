part of 'subjects_cubit.dart';

sealed class SubjectsState extends Equatable {
  const SubjectsState();

  @override
  List<Object> get props => [];
}

final class SubjectsInitial extends SubjectsState {}

final class GetSubjectsSucess extends SubjectsState {
  final List<SubjectsData> subjectsData;

  const GetSubjectsSucess({required this.subjectsData});
}

final class GetSubjectsError extends SubjectsState {
  final String erroMsg;

  const GetSubjectsError({required this.erroMsg});
}

final class GetSubjectsLoading extends SubjectsState {
  const GetSubjectsLoading();
}
