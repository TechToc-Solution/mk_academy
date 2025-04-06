part of 'leaderboard_cubit.dart';

abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {
  final bool isFirstFetch;

  const LeaderboardLoading({this.isFirstFetch = true});

  @override
  List<Object> get props => [isFirstFetch];
}

class LeaderboardSuccess extends LeaderboardState {
  final List<StudentsLeaderboardModel> students;

  const LeaderboardSuccess({required this.students});

  @override
  List<Object> get props => [students];
}

class LeaderboardError extends LeaderboardState {
  final String errorMsg;

  const LeaderboardError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
