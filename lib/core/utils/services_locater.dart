import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mk_academy/features/auth/data/repos/login_repo/login_repo.dart';
import 'package:mk_academy/features/auth/data/repos/login_repo/login_repo_ipml.dart';
import 'package:mk_academy/features/auth/data/repos/register_repo/register_repo.dart';

import '../../features/auth/data/repos/register_repo/register_repo_iplm.dart';
import '../Api_services/api_services.dart';

final getit = GetIt.instance;

void setupLocatorServices() {
  // init Dio
  getit.registerSingleton<Dio>(Dio(BaseOptions(
      connectTimeout: Duration(milliseconds: 30),
      sendTimeout: const Duration(milliseconds: 30),
      receiveTimeout: Duration(milliseconds: 30))));
  // init API Service
  getit.registerSingleton<ApiServices>(ApiServices(getit.get<Dio>()));

  getit.registerSingleton<LoginRepo>(LoginRepoIpml(getit.get<ApiServices>()));

  getit.registerSingleton<RegisterRepo>(
      RegisterRepoIplm(getit.get<ApiServices>()));
}
