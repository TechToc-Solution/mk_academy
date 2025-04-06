import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/errors/error_handler.dart';

import 'package:mk_academy/core/errors/failuer.dart';

import 'package:mk_academy/features/leaderboard/data/models/students_leaderboard_model.dart';

import '../../../../core/Api_services/urls.dart';
import 'leaderboard_repo.dart';

class LeaderboardRepoIplm implements LeaderboardRepo {
  final ApiServices _apiServices;

  LeaderboardRepoIplm(this._apiServices);
  @override
  Future<Either<Failure, StudentsLeaderboardData>> getLeaderbord(
      int page) async {
    try {
      var resp =
          await _apiServices.get(endPoint: "${Urls.getLeaderbord}/?page=$page");

      if (resp.statusCode == 200 || resp.data['success']) {
        final students = StudentsLeaderboardData.fromJson(resp.data['data']);

        return right(students);
      }
      return left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
