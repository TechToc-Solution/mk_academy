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
  Future<Either<Failure, TestsData>> getTests(
      {required int testsType, required int page, String? search}) async {
    try {
      var resp = testsType == 0
          ? await _apiServices.get(endPoint: Urls.getGeneralTests)
          : await _apiServices.get(endPoint: Urls.getSpecialTests);
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(TestsData.fromJson(resp.data['data']));
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
