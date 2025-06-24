import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/Api_services/urls.dart';
import 'package:mk_academy/core/errors/failuer.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';
import 'package:mk_academy/features/show_video/data/repo/video_repo.dart';

import '../../../../core/errors/error_handler.dart';

class VideoRepoIplm implements VideoRepo {
  final ApiServices _apiServices;

  VideoRepoIplm(this._apiServices);

  @override
  Future<Either<Failure, VideoDataModel>> getVideo(
      {required int? courseId, required int? videoId}) async {
    try {
      var resp = await _apiServices.get(
          endPoint: "${Urls.getCourses}/$courseId/videos/$videoId");

      if (resp.statusCode == 200 && resp.data['success']) {
        var realResp = decryptVideoData(
          resp.data['data'],
          CacheHelper.getData(key: "token"),
        );

        VideoDataModel video = VideoDataModel.fromJson(json.decode(realResp));

        return right(video);
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> markAsWatched({
    required int courseId,
    required int videoId,
  }) async {
    try {
      var resp = await _apiServices.post(
          endPoint: "${Urls.getCourses}/$courseId/videos/$videoId/mark-view",
          data: {});
      if (resp.statusCode == 204) {
        return right(null);
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
