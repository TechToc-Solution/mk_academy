import 'package:dartz/dartz.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';

abstract class ProfileRepo {
  Future<Either<String, UserModel>> getUserProfile();
}
