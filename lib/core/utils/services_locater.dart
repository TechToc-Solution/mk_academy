import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mk_academy/features/auth/data/repos/login_repo/login_repo.dart';
import 'package:mk_academy/features/auth/data/repos/login_repo/login_repo_ipml.dart';
import 'package:mk_academy/features/auth/data/repos/register_repo/register_repo.dart';
import 'package:mk_academy/features/leaderboard/data/repos/leaderboard_repo.dart';
import 'package:mk_academy/features/leaderboard/data/repos/leaderboard_repo_iplm.dart';
import 'package:mk_academy/features/profile/data/repos/profile_repo.dart';
import 'package:mk_academy/features/profile/data/repos/profile_repo_iplm.dart';

import '../../features/auth/data/repos/register_repo/register_repo_iplm.dart';
import '../Api_services/api_services.dart';

final getit = GetIt.instance;

void setupLocatorServices() {
  // init Dio
  getit.registerSingleton<Dio>(Dio(BaseOptions(
      connectTimeout: Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
      receiveTimeout: Duration(minutes: 1))));
  // init API Service
  getit.registerSingleton<ApiServices>(ApiServices(getit.get<Dio>()));

  //auth singleton
  getit.registerSingleton<LoginRepo>(LoginRepoIpml(getit.get<ApiServices>()));
  getit.registerSingleton<RegisterRepo>(
      RegisterRepoIplm(getit.get<ApiServices>()));
  getit.registerSingleton<ProfileRepo>(
      ProfileRepoIplm(getit.get<ApiServices>()));

  //leaderboard singleton
  getit.registerSingleton<LeaderboardRepo>(
      LeaderboardRepoIplm(getit.get<ApiServices>()));
}
