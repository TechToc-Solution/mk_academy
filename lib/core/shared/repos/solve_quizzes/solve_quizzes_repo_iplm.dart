import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';

import '../../../Api_services/urls.dart';
import '../../../errors/error_handler.dart';
import '../../../errors/failuer.dart';
import 'solve_quizzes_repo.dart';

class SolveQuizzesRepoIplm implements SolveQuizzesRepo {
  final ApiServices _apiServices;

  SolveQuizzesRepoIplm(this._apiServices);
  @override
  Future<Either<Failure, void>> submitQuizAnswers(
      {required int quizId,
      required List<Map<String, dynamic>> answers,
      required bool isCurriculumQuizz}) async {
    try {
      final data = {"answers": answers};
      var resp = await _apiServices.post(
        endPoint: isCurriculumQuizz
            ? "units/curriculum/$quizId"
            : "${Urls.getTestsDetails}/$quizId/solve",
        data: data,
      );

      if (resp.statusCode == 200 && resp.data['success']) {
        return right(null);
      }
      return left(
        ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()),
      );
    } catch (e) {
      log(e.toString());
      return left(ErrorHandler.handle(e));
    }
  }
}
