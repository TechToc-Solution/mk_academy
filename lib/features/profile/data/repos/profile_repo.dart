import 'package:dartz/dartz.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';

import '../../../../core/errors/failuer.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> getUserProfile();
}
