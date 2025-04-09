part of 'solve_quizzes_cubit.dart';

sealed class SolveQuizzesState extends Equatable {
  const SolveQuizzesState();

  @override
  List<Object> get props => [];
}

final class SolveQuizzesInitial extends SolveQuizzesState {}

class AnswersSubmitting extends SolveQuizzesState {
  final int quizId;
  const AnswersSubmitting({required this.quizId});
}

class AnswersSubmittedSuccess extends SolveQuizzesState {}

class AnswersSubmittedError extends SolveQuizzesState {
  final String errorMsg;
  const AnswersSubmittedError({required this.errorMsg});
}
