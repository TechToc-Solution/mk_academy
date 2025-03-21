part of 'leaderboard_cubit.dart';

sealed class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

final class LeaderboardInitial extends LeaderboardState {}

final class LeaderboardSuccess extends LeaderboardState {
  final List<StudentsLeaderboardModel> students;

  LeaderboardSuccess({required this.students});
}

final class LeaderboardError extends LeaderboardState {
  final String errorMsg;

  LeaderboardError({required this.errorMsg});
}

final class LeaderboardLoading extends LeaderboardState {}
