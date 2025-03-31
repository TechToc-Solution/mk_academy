part of 'test_your_self_cubit.dart';

enum TestYourSelfStatus { initial, loading, success, failure }

class TestYourSelfState extends Equatable {
  final TestYourSelfStatus status;
  final List<Tests> tests;
  final bool hasReachedMax;
  final int currentPage;
  final String? errorMessage;

  const TestYourSelfState({
    this.status = TestYourSelfStatus.loading,
    this.tests = const [],
    this.hasReachedMax = false,
    this.currentPage = 0,
    this.errorMessage,
  });

  TestYourSelfState copyWith({
    TestYourSelfStatus? status,
    List<Tests>? tests,
    bool? hasReachedMax,
    int? currentPage,
    String? errorMessage,
  }) {
    return TestYourSelfState(
      status: status ?? this.status,
      tests: tests ?? this.tests,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tests,
        hasReachedMax,
        currentPage,
        errorMessage,
      ];
}
