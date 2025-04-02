import 'package:dartz/dartz.dart';

import '../../../../core/errors/failuer.dart';
import '../model/tests_model.dart';

abstract class TestsRepo {
  Future<Either<Failure, TestsModel>> getTests({
    required int testsType,
    required int page,
  });
  Future<Either<Failure, Tests>> getTestDetails(int testId);
}
