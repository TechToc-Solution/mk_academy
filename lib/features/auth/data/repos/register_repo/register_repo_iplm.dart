import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/Api_services/urls.dart';
import 'package:mk_academy/core/errors/error_handler.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/features/auth/data/models/city_model.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';
import 'package:mk_academy/features/auth/data/repos/register_repo/register_repo.dart';

import '../../../../../core/errors/failuer.dart';
import '../../../../../core/utils/constats.dart';

class RegisterRepoIplm implements RegisterRepo {
  final ApiServices _apiServices;

  RegisterRepoIplm(this._apiServices);

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    try {
      var resp = await _apiServices.get(endPoint: Urls.getCities);
      List<City> cities = [];
      if (resp.statusCode == 200 && resp.data['success']) {
        for (var city in resp.data['data']) {
          cities.add(City.fromJson(city));
        }
      }
      return right(cities);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> register(
      Map<String, dynamic> registerData) async {
    try {
      var resp =
          await _apiServices.post(endPoint: Urls.register, data: registerData);
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(resp.data['data']['phone']);
      }
      return left(
          resp.data['message'] ?? ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> verifiPhoneNum(
      {required String phoneNumber, required String code}) async {
    try {
      var resp = await _apiServices.post(
          endPoint: Urls.verifiPhoneNum,
          data: {"phone": phoneNumber, "code": code});
      if (resp.statusCode == 200 && resp.data['success']) {
        CacheHelper.setString(key: 'token', value: resp.data['data']['token']);
        CacheHelper.setString(
            key: "userId", value: resp.data['data']['user']['id'].toString());
        isGuest = false;
        return right(UserModel.fromJson(resp.data['data']['user']));
      }
      return left(
          resp.data['message'] ?? ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
