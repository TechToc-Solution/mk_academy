import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/errors/failuer.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';
import 'package:mk_academy/features/auth/data/repos/login_repo/login_repo.dart';

import '../../../../../core/Api_services/urls.dart';
import '../../../../../core/errors/error_handler.dart';

class LoginRepoIpml implements LoginRepo {
  final ApiServices apiServices;

  LoginRepoIpml(this.apiServices);
  @override
  Future<Either<Failure, UserModel>> login(String pass, String phone) async {
    try {
      var resp = await apiServices
          .post(endPoint: Urls.login, data: {"phone": phone, "password": pass});
      if (resp.statusCode == 200 && resp.data['success']) {
        CacheHelper.setString(key: 'token', value: resp.data["data"]["token"]);
        return right(UserModel.fromJson(resp.data["data"]["user"]));
      }
      return left(
          resp.data['message'] ?? ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
