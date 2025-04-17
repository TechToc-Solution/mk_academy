import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failuer.dart';
import '../../model/ads_model.dart';

abstract class AdsRepo {
  Future<Either<Failure, AdsData>> getAds({
    required int adsType,
    required int page,
    String? search,
  });
}
