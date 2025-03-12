import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/leaderboard/data/models/students_leaderboard_model.dart';
import 'package:mk_academy/features/leaderboard/data/repos/leaderboard_repo.dart';

part 'leaderboard_state.dart';

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit(this._leaderbordRepo) : super(LeaderboardInitial());
  final LeaderboardRepo _leaderbordRepo;
  Future getLeaderbord() async {
    emit(LeaderboardLoading());
    var data = await _leaderbordRepo.getLeaderbord();
    data.fold((failure) {
      emit(LeaderboardError(errorMsg: failure.message));
    }, (students) {
      emit(LeaderboardSuccess(students: students));
    });
  }
}
