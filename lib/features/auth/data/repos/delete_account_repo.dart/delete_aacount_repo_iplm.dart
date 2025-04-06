import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/Api_services/urls.dart';
import 'package:mk_academy/core/errors/failuer.dart';
import 'package:mk_academy/core/errors/error_handler.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/core/utils/constats.dart';

import 'delete_account_repo.dart';

class DeleteAccountRepoIplm implements DeleteAccountRepo {
  final ApiServices _apiServices;

  DeleteAccountRepoIplm(this._apiServices);

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      final response = await _apiServices.delete(
        endPoint: Urls.getProfile,
      );

      if (response.statusCode == 204) {
        CacheHelper.removeData(key: "token");
        isGuest = true;
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
