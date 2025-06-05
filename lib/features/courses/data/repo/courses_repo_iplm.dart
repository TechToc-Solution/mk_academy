import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/Api_services/urls.dart';
import 'package:mk_academy/core/errors/failuer.dart';
import 'package:mk_academy/features/courses/data/model/courses_model.dart';
import 'package:mk_academy/features/courses/data/model/video_model.dart';
import 'package:mk_academy/features/courses/data/repo/courses_repo.dart';

import '../../../../core/errors/error_handler.dart';

class CoursesRepoIplm implements CoursesRepo {
  final ApiServices _apiServices;

  CoursesRepoIplm(this._apiServices);
  @override
  Future<Either<Failure, CoursesData>> getCourses(
      {required int? courseTypeId,
      required int subjectId,
      required int page,
      String? search}) async {
    try {
      var resp = await _apiServices.get(
          endPoint:
              "${Urls.getCourses}?name=${search ?? ""}&course_type_id=${courseTypeId ?? ""}&subject_id=$subjectId&page=$page");
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(CoursesData.fromJson(resp.data['data']));
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Courses>> getCourse({
    required int? courseId,
  }) async {
    try {
      var resp =
          await _apiServices.get(endPoint: "${Urls.getCourses}/$courseId");
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(Courses.fromJson(resp.data['data']));
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, VideoData>> getVideos({
    required int? courseId,
  }) async {
    try {
      var resp = await _apiServices.get(
          endPoint: "${Urls.getCourses}/$courseId/videos");
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(VideoData.fromJson(resp.data));
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
