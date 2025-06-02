import 'package:dartz/dartz.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';

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

  Future<Either<Failure, VideoData>> getVideos({
    required int? courseId,
  });

  Future<Either<Failure, void>> markAsWatched({
    required int courseId,
    required int videoId,
  });
}
