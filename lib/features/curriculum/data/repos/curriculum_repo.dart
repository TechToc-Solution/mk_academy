import 'package:dartz/dartz.dart';

import '../../../../core/errors/failuer.dart';
import '../model/lesson_model.dart';
import '../model/units_model.dart';

abstract class CurriculumRepo {
  Future<Either<Failure, UnitsModel>> fetchUnits(int subjectId);
  Future<Either<Failure, LessonsModel>> fetchLessons(int unitId, int page);
  Future<Either<Failure, Lesson>> fetchLessonDetails(int lessonId);
}
