import 'package:dartz/dartz.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';

import '../../../../core/errors/failuer.dart';
import '../../presentation/params/update_profile_params.dart';

abstract class ProfileRepo {
  Future<Either<Failure, UserModel>> getUserProfile();
  Future<Either<Failure, UserModel>> updateUserProfile(
      UpdateProfileParams params);
}
