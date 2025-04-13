// pay_repo_iplm.dart
import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/shared/models/version_model.dart';

import '../../../Api_services/api_services.dart';
import '../../../Api_services/urls.dart';
import '../../../errors/error_handler.dart';
import '../../../errors/failuer.dart';
import 'pay_repo.dart';

class AppVersionIplm implements AppVersionRepo {
  final ApiServices _apiServices;

  AppVersionIplm(this._apiServices);

  @override
  Future<Either<Failure, VersionModel>> getVersionFromApi() async {
    try {
      var resp = await _apiServices.get(endPoint: Urls.getVersion);
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(VersionModel.fromJson(resp.data['data']));
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
