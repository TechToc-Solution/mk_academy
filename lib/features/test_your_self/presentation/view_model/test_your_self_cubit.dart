import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/test_your_self/data/model/tests_model.dart';
import 'package:mk_academy/features/test_your_self/data/repo/tests_repo.dart';

part 'test_your_self_state.dart';

class TestYourSelfCubit extends Cubit<TestYourSelfState> {
  final TestsRepo _testsRepo;
  List<Tests> tests = [];
  Tests? testDetails;
  int _currentPage = 1;
  bool hasReachedMax = false;

  TestYourSelfCubit(this._testsRepo) : super(TestYourSelfInitial());

  Future<void> getTests({
    required int testsType,
    bool loadMore = false,
  }) async {
    if (isClosed || hasReachedMax) return;

    if (!loadMore) {
      _currentPage = 1;
      hasReachedMax = false;
      tests.clear();
      emit(const TestsLoading(isFirstFetch: true));
    } else {
      emit(const TestsLoading(isFirstFetch: false));
    }

    final result = await _testsRepo.getTests(
      testsType: testsType,
      page: _currentPage,
    );

    if (!isClosed) {
      result.fold(
        (failure) => emit(TestsError(errorMsg: failure.message)),
        (testsModel) {
          _currentPage++;
          hasReachedMax = !testsModel.hasNext!;
          tests = [...tests, ...testsModel.tests!];
          emit(TestsSuccess());
        },
      );
    }
  }

  Future<void> getTestDetails(int testId) async {
    if (isClosed) return;

    emit(TestDetailsLoading(testId: testId));

    final result = await _testsRepo.getTestDetails(testId);

    if (!isClosed) {
      result.fold(
        (failure) => emit(TestDetailsError(errorMsg: failure.message)),
        (details) {
          testDetails = details;
          emit(TestDetailsSuccess(testDetails: details));
        },
      );
    }
  }

  void resetPagination() {
    _currentPage = 1;
    hasReachedMax = false;
    tests.clear();
    emit(TestYourSelfInitial());
  }
}
