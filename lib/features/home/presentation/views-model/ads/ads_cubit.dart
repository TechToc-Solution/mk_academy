import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/home/data/model/ads_model.dart';
import 'package:mk_academy/features/home/data/repo/ads.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit(this._AdsRepo) : super(AdsState());
  final AdsRepo _AdsRepo;
  Future<void> getAllAds({
    String? search,
  }) async {
    var dataInt = await _AdsRepo.getAds(adsType: 0, page: 1);
    var dataExt = await _AdsRepo.getAds(adsType: 1, page: 1);
    dataInt.fold(
        (failure) => emit(state.copyWith(
              status: AdsStatus.failure,
              errorMessage: failure.message,
            )), (adsIntData) {
      final newIntAds = [
        ...state.adsInt,
        ...adsIntData.ads!,
      ];
      dataExt.fold(
          (failure) => emit(state.copyWith(
                status: AdsStatus.failure,
                errorMessage: failure.message,
              )), (adsExtData) {
        final newExtAds = [
          ...state.adsExt,
          ...adsExtData.ads!,
        ];
        emit(state.copyWith(
            adsInt: newIntAds,
            adsExt: newExtAds,
            // currentPage: adsData.currentPage,
            currentPage: 1,
            status: AdsStatus.success,
            //hasReachedMax: !coursesData.hasNext!,
            hasReachedMax: true));
      });
    });
  }

  Future<void> getAds({
    required int adsType,
    String? search,
  }) async {
    var data = await _AdsRepo.getAds(adsType: adsType, page: 1);

    data.fold(
        (failure) => emit(state.copyWith(
              status: AdsStatus.failure,
              errorMessage: failure.message,
            )), (adsData) {
      final newAds = adsType == 0
          ? [
              ...state.adsInt,
              ...adsData.ads!,
            ]
          : [
              ...state.adsExt,
              ...adsData.ads!,
            ];
      if (adsType == 0) {
        emit(state.copyWith(
            adsInt: newAds,
            // currentPage: adsData.currentPage,
            currentPage: 1,
            status: AdsStatus.success,
            //hasReachedMax: !coursesData.hasNext!,
            hasReachedMax: true));
      } else {
        emit(state.copyWith(
            adsExt: newAds,
            // currentPage: adsData.currentPage,
            currentPage: 1,
            status: AdsStatus.success,
            //hasReachedMax: !coursesData.hasNext!,
            hasReachedMax: true));
      }
    });
  }

  void resetPagination() {
    emit(const AdsState());
  }
}
