import 'package:dartz/dartz.dart';

import '../../../../core/errors/failuer.dart';
import '../model/courses_model.dart';

abstract class CoursesRepo {
  Future<Either<Failure, CoursesData>> getCourses({
    required int? courseTypeId,
    required int subjectId,
    required int page,
    String? search,
  });

  Future<Either<Failure, Courses>> getCourse({
    required int? courseId,
  });
}
