import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/home/data/model/ads_model.dart';
import 'package:mk_academy/features/home/data/repo/ads/ads.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit(this._adsRepo) : super(AdsState());
  final AdsRepo _adsRepo;
  Future<void> getAllAds({
    String? search,
  }) async {
    emit(state.copyWith(status: AdsStatus.loading));

    // Fetch internal and external ads in parallel
    final results = await Future.wait([
      _adsRepo.getAds(adsType: 0, page: 1),
      _adsRepo.getAds(adsType: 1, page: 1),
    ]);

    // Debug prints
    results[0].fold(
      (failure) => log('Internal ads error: ${failure.message}'),
      (data) => log('Internal ads data: ${data.ads?.length} items'),
    );

    results[1].fold(
      (failure) => log('External ads error: ${failure.message}'),
      (data) => log('External ads data: ${data.ads?.length} items'),
    );
    // Process results
    final internalAds = results[0];
    final externalAds = results[1];

    // Handle errors using fold
    internalAds.fold(
      (failure) => emit(state.copyWith(
        status: AdsStatus.failure,
        errorMessage: failure.message,
      )),
      (internalData) {
        externalAds.fold(
          (failure) => emit(state.copyWith(
            status: AdsStatus.failure,
            errorMessage: failure.message,
          )),
          (externalData) {
            emit(state.copyWith(
              adsInt: internalData.ads ?? [],
              adsExt: externalData.ads ?? [],
              currentPage: 1,
              status: AdsStatus.success,
              hasReachedMax: true,
            ));
          },
        );
      },
    );
  }

  Future<void> getAds({
    required int adsType,
    String? search,
  }) async {
    emit(state.copyWith(status: AdsStatus.loading));

    final result = await _adsRepo.getAds(adsType: adsType, page: 1);

    result.fold(
      (failure) => emit(state.copyWith(
        status: AdsStatus.failure,
        errorMessage: failure.message,
      )),
      (adsData) {
        // Preserve the existing ads of the other type
        if (adsType == 0) {
          emit(state.copyWith(
            adsInt: adsData.ads ?? [],
            adsExt: state.adsExt, // Keep existing external ads
            status: AdsStatus.success,
          ));
        } else {
          emit(state.copyWith(
            adsInt: state.adsInt, // Keep existing internal ads
            adsExt: adsData.ads ?? [],
            status: AdsStatus.success,
          ));
        }
      },
    );
  }

  void resetPagination() {
    emit(const AdsState());
  }
}
