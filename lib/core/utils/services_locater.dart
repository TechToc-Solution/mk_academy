import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mk_academy/core/shared/repos/pay/pay_repo.dart';
import 'package:mk_academy/core/shared/repos/pay/pay_repo_iplm.dart';
import 'package:mk_academy/core/shared/repos/solve_quizzes/solve_quizzes_repo.dart';
import 'package:mk_academy/features/auth/data/repos/delete_account_repo.dart/delete_aacount_repo_iplm.dart';
import 'package:mk_academy/features/auth/data/repos/delete_account_repo.dart/delete_account_repo.dart';
import 'package:mk_academy/features/auth/data/repos/token_repo/token_repo.dart';
import 'package:mk_academy/features/auth/data/repos/token_repo/token_repo_ipml.dart';
import 'package:mk_academy/features/home/data/repo/ads.dart';
import 'package:mk_academy/features/home/data/repo/ads_repo_iplm.dart';
import 'package:mk_academy/features/test_your_self/data/repo/tests_repo.dart';
import 'package:mk_academy/features/test_your_self/data/repo/tests_repo_iplm.dart';

import '../../features/auth/data/repos/login_repo/login_repo.dart';
import '../../features/auth/data/repos/login_repo/login_repo_ipml.dart';
import '../../features/auth/data/repos/logout_repo/logout_repo.dart';
import '../../features/auth/data/repos/logout_repo/logout_repo_iplm.dart';
import '../../features/auth/data/repos/register_repo/register_repo.dart';
import '../../features/auth/data/repos/register_repo/register_repo_iplm.dart';
import '../../features/auth/data/repos/reset_password_repo/reset_password_repo.dart';
import '../../features/auth/data/repos/reset_password_repo/reset_password_repo_iplm.dart';
import '../../features/courses/data/repo/courses_repo.dart';
import '../../features/courses/data/repo/courses_repo_iplm.dart';
import '../../features/curriculum/data/repos/curriculum_repo.dart';
import '../../features/curriculum/data/repos/curriculum_repo_iplm.dart';
import '../../features/leaderboard/data/repos/leaderboard_repo.dart';
import '../../features/leaderboard/data/repos/leaderboard_repo_iplm.dart';
import '../../features/profile/data/repos/profile_repo.dart';
import '../../features/profile/data/repos/profile_repo_iplm.dart';
import '../Api_services/api_services.dart';
import '../shared/repos/solve_quizzes/solve_quizzes_repo_iplm.dart';
import '../shared/repos/subjects/subjects_repo.dart';
import '../shared/repos/subjects/subjects_repo_iplm.dart';

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

  getit.registerSingleton<TokenRepo>(TokenRepoIpml(getit.get<ApiServices>()));

  getit.registerSingleton<RegisterRepo>(
      RegisterRepoIplm(getit.get<ApiServices>()));

  getit.registerSingleton<ProfileRepo>(
      ProfileRepoIplm(getit.get<ApiServices>()));

  getit.registerSingleton<LogoutRepo>(LogoutRepoIplm(getit.get<ApiServices>()));

  getit.registerSingleton<ResetPasswordRepo>(
      ResetPasswordRepoImpl(getit.get<ApiServices>()));

  getit.registerSingleton<DeleteAccountRepo>(
      DeleteAccountRepoIplm(getit.get<ApiServices>()));

  //leaderboard singleton
  getit.registerSingleton<LeaderboardRepo>(
      LeaderboardRepoIplm(getit.get<ApiServices>()));

  //courses singleton
  getit.registerSingleton<CoursesRepo>(CoursesRepoIplm(getit<ApiServices>()));

  //subjects singleton
  getit.registerSingleton<SubjectsRepo>(SubjectsRepoIplm(getit<ApiServices>()));

  //curriculum singleton
  getit.registerSingleton<CurriculumRepo>(
      CurriculumRepoIplm(getit.get<ApiServices>()));

  //Tests singleton
  getit.registerSingleton<TestsRepo>(TestsRepoIplm(getit.get<ApiServices>()));

  //Ads singleton
  getit.registerSingleton<AdsRepo>(AdsRepoIplm(getit.get<ApiServices>()));

  //pay singleton
  getit.registerSingleton<PayRepo>(PayRepoIplm(getit.get<ApiServices>()));

  //Sovle quizzes singleton
  getit.registerSingleton<SolveQuizzesRepo>(
      SolveQuizzesRepoIplm(getit.get<ApiServices>()));
}
