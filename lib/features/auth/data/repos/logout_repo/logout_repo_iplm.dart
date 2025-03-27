import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/errors/error_handler.dart';

import 'package:mk_academy/core/errors/failuer.dart';

import '../../../../../core/Api_services/urls.dart';
import 'logout_repo.dart';

class LogoutRepoIplm implements LogoutRepo {
  final ApiServices _apiServices;

  LogoutRepoIplm(this._apiServices);
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      var resp = await _apiServices.post(endPoint: Urls.logout, data: {});
      if (resp.statusCode == 204) {
        return right(null);
      }
      return left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
