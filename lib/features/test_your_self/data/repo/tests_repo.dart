import 'package:dartz/dartz.dart';

import '../../../../core/errors/failuer.dart';
import '../model/tests_model.dart';

abstract class TestsRepo {
  Future<Either<Failure, TestsData>> getTests({
    required int testsType,
    required int page,
    String? search,
  });
}
