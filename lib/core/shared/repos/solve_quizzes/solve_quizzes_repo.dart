import 'package:dartz/dartz.dart';

import '../../../errors/failuer.dart';

abstract class SolveQuizzesRepo {
  Future<Either<Failure, void>> submitQuizAnswers(
      {required int quizId,
      required List<Map<String, dynamic>> answers,
      required bool isCurriculumQuizz});
}
