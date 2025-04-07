import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/students_leaderboard_model.dart';
import '../../data/repos/leaderboard_repo.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  final LeaderboardRepo _leaderboardRepo;
  List<StudentsLeaderboardModel> students = [];
  int _currentPage = 1;
  bool hasReachedMax = false;

  LeaderboardCubit(this._leaderboardRepo) : super(LeaderboardInitial());

  Future<void> getLeaderboard({bool loadMore = false}) async {
    if (isClosed || (hasReachedMax && loadMore)) return;

    if (!loadMore) {
      _currentPage = 1;
      hasReachedMax = false;
      students.clear();
      emit(LeaderboardLoading(isFirstFetch: true));
    } else {
      emit(LeaderboardLoading(isFirstFetch: false));
    }

    final result = await _leaderboardRepo.getLeaderbord(_currentPage);

    if (!isClosed) {
      return result.fold(
        (failure) => emit(LeaderboardError(errorMsg: failure.message)),
        (data) {
          _currentPage++;
          hasReachedMax = !data.hasNext!;
          students = [...students, ...data.students!];
          emit(LeaderboardSuccess(students: students));
        },
      );
    }
  }

  void resetLeaderboard() {
    _currentPage = 1;
    hasReachedMax = false;
    students.clear();
    emit(LeaderboardInitial());
  }
}
