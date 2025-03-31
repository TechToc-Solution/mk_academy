import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/home/data/model/ads_model.dart';
import 'package:mk_academy/features/home/data/repo/ads.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit(this._AdsRepo) : super(AdsState());
  final AdsRepo _AdsRepo;
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
      final newAds = [
        ...state.ads,
        ...adsData.ads!,
      ];
      emit(state.copyWith(
          ads: newAds,
          // currentPage: adsData.currentPage,
          currentPage: 1,
          status: AdsStatus.success,
          //hasReachedMax: !coursesData.hasNext!,
          hasReachedMax: true));
    });
  }

  void resetPagination() {
    emit(const AdsState());
  }
}
