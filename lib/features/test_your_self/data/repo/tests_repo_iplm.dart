import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/Api_services/urls.dart';
import 'package:mk_academy/core/errors/failuer.dart';
import 'package:mk_academy/features/test_your_self/data/model/tests_model.dart';
import 'package:mk_academy/features/test_your_self/data/repo/tests_repo.dart';

import '../../../../core/errors/error_handler.dart';

class TestsRepoIplm implements TestsRepo {
  final ApiServices _apiServices;

  TestsRepoIplm(this._apiServices);
  @override
  Future<Either<Failure, TestsModel>> getTests(
      {required int testsType, required int page}) async {
    try {
      var resp = await _apiServices.get(
          endPoint:
              "${testsType == 0 ? Urls.getGeneralTests : Urls.getSpecialTests}?page=$page");
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(TestsModel.fromJson(resp.data['data']));
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Tests>> getTestDetails(int testId) async {
    try {
      var resp = await _apiServices.get(
        endPoint: "${Urls.getTestsDetails}/$testId",
      );
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(Tests.fromJson(resp.data['data']));
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      log(e.toString());
      return left(ErrorHandler.handle(e));
    }
  }
}
