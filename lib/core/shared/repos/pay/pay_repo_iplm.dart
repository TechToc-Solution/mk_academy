// pay_repo_iplm.dart
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mk_academy/features/courses/data/model/courses_model.dart';

import '../../../Api_services/api_services.dart';
import '../../../Api_services/urls.dart';
import '../../../errors/error_handler.dart';
import '../../../errors/failuer.dart';
import 'pay_repo.dart';

class PayRepoIplm implements PayRepo {
  final ApiServices _apiServices;

  PayRepoIplm(this._apiServices);

  @override
  Future<Either<Failure, void>> payCourse(String code) async {
    try {
      final response = await _apiServices
          .post(endPoint: "${Urls.purchaseUse}/$code", data: {});

      if (response.statusCode == 204) {
        return right(null);
      }

      return left(ServerFailure(
        response.data['message'] ?? ErrorHandler.defaultMessage(),
      ));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<Courses>>> getCodeData({
    required String code,
  }) async {
    try {
      var resp =
          await _apiServices.get(endPoint: "${Urls.purchaseCheck}/$code");
      if (resp.statusCode == 200 && resp.data['success']) {
        List<Courses>? courses = <Courses>[];
        resp.data['data'].forEach((v) {
          courses.add(Courses.fromJson(v));
        });
        return right(courses);
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      log(e.toString());
      return left(ErrorHandler.handle(e));
    }
  }
}
