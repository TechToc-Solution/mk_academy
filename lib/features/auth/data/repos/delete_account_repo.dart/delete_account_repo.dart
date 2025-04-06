import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/errors/failuer.dart';

abstract class DeleteAccountRepo {
  Future<Either<Failure, void>> deleteAccount();
}
