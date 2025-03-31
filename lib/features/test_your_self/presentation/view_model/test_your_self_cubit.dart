import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/test_your_self/data/model/tests_model.dart';
import 'package:mk_academy/features/test_your_self/data/repo/tests_repo.dart';

part 'test_your_self_state.dart';

class TestYourSelfCubit extends Cubit<TestYourSelfState> {
  TestYourSelfCubit(this._TestsRepo) : super(TestYourSelfState());
  final TestsRepo _TestsRepo;
  Future<void> getTests({
    required int testsType,
    String? search,
  }) async {
    if (state.hasReachedMax || isClosed) return;
    var data = await _TestsRepo.getTests(
        testsType: testsType, page: state.currentPage + 1);
    if (!isClosed) {
      data.fold(
          (failure) => emit(state.copyWith(
                status: TestYourSelfStatus.failure,
                errorMessage: failure.message,
              )), (TestsData) {
        final List<Tests> newTests = [
          ...state.tests,
          ...TestsData.tests!,
        ];
        emit(state.copyWith(
          tests: newTests,
          currentPage: TestsData.currentPage,
          status: TestYourSelfStatus.success,
          hasReachedMax: !TestsData.hasNext!,
        ));
      });
    }
  }

  void resetPagination() {
    emit(const TestYourSelfState());
  }
}
