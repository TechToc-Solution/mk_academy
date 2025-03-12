import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/errors/failuer.dart';

import '../../models/city_model.dart';
import '../../models/user_model.dart';

abstract class RegisterRepo {
  Future<Either<Failure, String>> register(Map<String, dynamic> registerData);
  Future<Either<Failure, List<City>>> getCities();
  Future<Either<Failure, UserModel>> verifiPhoneNum(
      {required String phoneNumber, required String code});
}
