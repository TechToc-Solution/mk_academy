import 'package:dartz/dartz.dart';
import 'package:mk_academy/features/show_video/data/Models/video_model.dart';

import '../../../../core/errors/failuer.dart';

abstract class VideoRepo {
  Future<Either<Failure, VideoDataModel>> getVideo({
    required int? courseId,
    required int? videoId,
  });

  Future<Either<Failure, void>> markAsWatched({
    required int courseId,
    required int videoId,
  });
}
