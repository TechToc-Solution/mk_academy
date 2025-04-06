part of 'ads_cubit.dart';

enum AdsStatus { initial, loading, success, failure }

class AdsState extends Equatable {
  final AdsStatus status;
  final List<Ads> adsInt;
  final List<Ads> adsExt;
  final bool hasReachedMax;
  final int currentPage;
  final String? errorMessage;

  const AdsState({
    this.status = AdsStatus.loading,
    this.adsInt = const [],
    this.adsExt = const [],
    this.hasReachedMax = false,
    this.currentPage = 0,
    this.errorMessage,
  });
  AdsState copyWith({
    AdsStatus? status,
    List<Ads>? adsInt,
    List<Ads>? adsExt,
    bool? hasReachedMax,
    int? currentPage,
    String? errorMessage,
  }) {
    return AdsState(
      status: status ?? this.status,
      adsInt: adsInt ?? this.adsInt,
      adsExt: adsInt ?? this.adsExt,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        adsInt,
        adsExt,
        hasReachedMax,
        currentPage,
        errorMessage,
      ];
}
