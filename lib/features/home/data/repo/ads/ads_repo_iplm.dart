
import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/Api_services/urls.dart';
import 'package:mk_academy/core/errors/failuer.dart';
import 'package:mk_academy/features/home/data/model/ads_model.dart';
import 'package:mk_academy/features/home/data/repo/ads/ads.dart';

import '../../../../../core/errors/error_handler.dart';

class AdsRepoIplm implements AdsRepo {
  final ApiServices _apiServices;

  AdsRepoIplm(this._apiServices);
  @override
  Future<Either<Failure, AdsData>> getAds(
      {required int adsType, required int page, String? search}) async {
    try {
      // 0 = internal : 1 = external
      var resp = adsType == 0
          ? await _apiServices.get(endPoint: Urls.getInternalAds)
          : await _apiServices.get(endPoint: Urls.getExternalAds);
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(AdsData.fromJson(resp.data));
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      // log(e.toString());
      return left(ErrorHandler.handle(e));
    }
  }
}
