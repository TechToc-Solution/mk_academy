import 'package:dartz/dartz.dart';

import '../../models/user_model.dart';

abstract class LoginRepo {
  Future<Either<String, UserModel>> login(String pass, String phone);
}
