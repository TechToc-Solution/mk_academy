import 'package:dartz/dartz.dart';

import '../../../errors/failuer.dart';
import '../../models/subjects_model.dart';

abstract class SubjectsRepo {
  Future<Either<Failure, SubjectsModel>> getSubjects();
}
