part of 'test_your_self_cubit.dart';

sealed class TestYourSelfState extends Equatable {
  const TestYourSelfState();

  @override
  List<Object> get props => [];
}

final class TestYourSelfInitial extends TestYourSelfState {}

// Tests List States
class TestsLoading extends TestYourSelfState {
  final bool isFirstFetch;

  const TestsLoading({this.isFirstFetch = true});
}

class TestsSuccess extends TestYourSelfState {}

class TestsError extends TestYourSelfState {
  final String errorMsg;

  const TestsError({required this.errorMsg});
}

// Test Details States
class TestDetailsLoading extends TestYourSelfState {
  final int testId;

  const TestDetailsLoading({required this.testId});

  @override
  List<Object> get props => [testId];
}

class TestDetailsSuccess extends TestYourSelfState {
  final Tests testDetails;

  const TestDetailsSuccess({required this.testDetails});
}

class TestDetailsError extends TestYourSelfState {
  final String errorMsg;

  const TestDetailsError({required this.errorMsg});
}
