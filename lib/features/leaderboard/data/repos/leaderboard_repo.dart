import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/errors/failuer.dart';
import 'package:mk_academy/features/leaderboard/data/models/students_leaderboard_model.dart';

abstract class LeaderboardRepo {
  Future<Either<Failure, List<StudentsLeaderboardModel>>> getLeaderbord();
}
