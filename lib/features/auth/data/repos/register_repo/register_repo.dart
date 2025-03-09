import 'package:dartz/dartz.dart';

import '../../models/city_model.dart';
import '../../models/user_model.dart';

abstract class RegisterRepo {
  Future<Either<String, String>> register(Map<String, dynamic> registerData);
  Future<Either<String, List<City>>> getCities();
  Future<Either<String, UserModel>> verifiPhoneNum(
      {required String phoneNumber, required String code});
}
