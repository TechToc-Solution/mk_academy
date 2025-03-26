import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/features/curriculum/data/repos/curriculum_repo.dart';

import '../../../../core/Api_services/urls.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failuer.dart';
import '../model/lesson_model.dart';
import '../model/units_model.dart';

class CurriculumRepoIplm implements CurriculumRepo {
  final ApiServices _apiServices;

  CurriculumRepoIplm(this._apiServices);

  @override
  Future<Either<Failure, UnitsModel>> fetchUnits(int subjectId) async {
    try {
      final resp =
          await _apiServices.get(endPoint: "${Urls.getSubjects}/$subjectId");

      if (resp.statusCode == 200 && resp.data['success']) {
        return Right(UnitsModel.fromJson(resp.data));
      } else {
        return Left(
            ServerFailure(resp.data['data'] ?? ErrorHandler.defaultMessage()));
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, LessonsModel>> fetchLessons(
      int unitId, int page) async {
    try {
      final resp = await _apiServices.get(
        endPoint: "units/$unitId/curriculum?page=$page",
      );

      if (resp.statusCode == 200 && resp.data['success']) {
        return Right(LessonsModel.fromJson(resp.data));
      } else {
        return Left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()),
        );
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
