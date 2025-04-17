// pay_repo.dart
import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/errors/failuer.dart';
import 'package:mk_academy/features/courses/data/model/courses_model.dart';

abstract class PayRepo {
  Future<Either<Failure, void>> payCourse(String code);
  Future<Either<Failure, List<Courses>>> getCodeData({
    required String code,
  });
}
