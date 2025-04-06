// pay_repo_iplm.dart
import 'package:dartz/dartz.dart';

import '../../../Api_services/api_services.dart';
import '../../../Api_services/urls.dart';
import '../../../errors/error_handler.dart';
import '../../../errors/failuer.dart';
import 'pay_repo.dart';

class PayRepoIplm implements PayRepo {
  final ApiServices _apiServices;

  PayRepoIplm(this._apiServices);

  @override
  Future<Either<Failure, void>> payCourse(int courseId, String code) async {
    try {
      final response = await _apiServices.post(
        endPoint: "${Urls.getCourses}/$courseId",
        data: {'code': code},
      );

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
}
