import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/core/shared/repos/solve_quizzes/solve_quizzes_repo.dart';

part 'solve_quizzes_state.dart';

class SolveQuizzesCubit extends Cubit<SolveQuizzesState> {
  final SolveQuizzesRepo _quizzesRepo;

  SolveQuizzesCubit(this._quizzesRepo) : super(SolveQuizzesInitial());

  final Map<int, List<Map<String, dynamic>>> _answers = {};

  Future<void> submitQuizAnswers(
      {required int quizId, required bool isCurriculumQuizz}) async {
    if (isClosed || !_answers.containsKey(quizId)) return;

    emit(AnswersSubmitting(quizId: quizId));

    final result = await _quizzesRepo.submitQuizAnswers(
        quizId: quizId,
        answers: _answers[quizId]!,
        isCurriculumQuizz: isCurriculumQuizz);

    if (!isClosed) {
      result.fold(
        (failure) => emit(AnswersSubmittedError(errorMsg: failure.message)),
        (response) {
          _answers.remove(quizId);
          emit(AnswersSubmittedSuccess());
        },
      );
    }
  }

  void storeAnswer({
    required int quizId,
    required int questionIndex,
    required int optionId,
    required int duration,
  }) {
    _answers.update(quizId, (existing) {
      if (questionIndex >= existing.length) {
        existing.add({'option_id': optionId, 'duration': duration});
      } else {
        existing[questionIndex] = {'option_id': optionId, 'duration': duration};
      }
      return existing;
    },
        ifAbsent: () => [
              {'option_id': optionId, 'duration': duration}
            ]);
  }

  void clearAnswers() {
    _answers.clear();
  }

  List<Map<String, dynamic>>? getQuizAnswers(int quizId) => _answers[quizId];
}
