// pay_repo.dart
import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/errors/failuer.dart';
import 'package:mk_academy/core/shared/models/version_model.dart';

abstract class AppVersionRepo {
  Future<Either<Failure, VersionModel>> getVersionFromApi();
}
