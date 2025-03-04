import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mk_academy/features/auth/data/repos/login_repo/login_repo.dart';
import 'package:mk_academy/features/auth/data/repos/login_repo/login_repo_ipml.dart';

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

  getit.registerSingleton<LoginRepo>(
      LoginRepoIpml(apiServices: getit.get<ApiServices>()));
}
