part of 'ads_cubit.dart';

enum AdsStatus { initial, loading, success, failure }

class AdsState extends Equatable {
  final AdsStatus status;
  final List<Ads> ads;
  final bool hasReachedMax;
  final int currentPage;
  final String? errorMessage;

  const AdsState({
    this.status = AdsStatus.loading,
    this.ads = const [],
    this.hasReachedMax = false,
    this.currentPage = 0,
    this.errorMessage,
  });
  AdsState copyWith({
    AdsStatus? status,
    List<Ads>? ads,
    bool? hasReachedMax,
    int? currentPage,
    String? errorMessage,
  }) {
    return AdsState(
      status: status ?? this.status,
      ads: ads ?? this.ads,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        ads,
        hasReachedMax,
        currentPage,
        errorMessage,
      ];
}
