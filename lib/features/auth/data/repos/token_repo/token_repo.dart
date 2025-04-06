import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/errors/failuer.dart';

import '../../models/user_model.dart';

abstract class TokenRepo {
  Future<Either<Failure, UserModel>> cheackToken();
}
