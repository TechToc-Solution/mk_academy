import 'package:dartz/dartz.dart';

import '../../../../core/errors/failuer.dart';
import '../model/units_model.dart';

abstract class CurriculumRepo {
  Future<Either<Failure, UnitsModel>> fetchUnits(int subjectId);
}
