import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/Api_services/urls.dart';
import 'package:mk_academy/core/errors/error_handler.dart';

import 'package:mk_academy/features/auth/data/models/user_model.dart';

import '../../../../core/errors/failuer.dart';
import 'profile_repo.dart';
import 'package:mk_academy/features/profile/presentation/params/update_profile_params.dart';

class ProfileRepoIplm implements ProfileRepo {
  final ApiServices _apiServices;

  ProfileRepoIplm(this._apiServices);
  @override
  Future<Either<Failure, UserModel>> getUserProfile() async {
    try {
      var resp = await _apiServices.get(endPoint: Urls.getProfile);
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(UserModel.fromJson(resp.data['data']));
      }
      return left(
          resp.data['message'] ?? ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateUserProfile(
      UpdateProfileParams params) async {
    try {
      var resp = await _apiServices.post(
        endPoint: Urls.updateProfile,
        data: params.toJson(),
      );
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(UserModel.fromJson(resp.data['data']));
      }
      return left(
          resp.data['message'] ?? ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
