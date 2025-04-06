// pay_repo.dart
import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/errors/failuer.dart';

abstract class PayRepo {
  Future<Either<Failure, void>> payCourse(int courseId, String code);
}
