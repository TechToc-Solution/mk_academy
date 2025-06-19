import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:mk_academy/core/Api_services/urls.dart';
import '../../features/auth/presentation/views/login/login_page.dart';
import 'auth_interceptor.dart';
import '../utils/cache_helper.dart';
import '../utils/constats.dart';

class ApiServices {
  final Dio _dio;
  ApiServices(this._dio) {
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _dio.options.baseUrl = Urls.baseUrl;
    // _dio.interceptors.add(
    //   PrettyDioLogger(
    //       requestHeader: true,
    //       requestBody: true,
    //       responseBody: true,
    //       responseHeader: true,
    //       error: true,
    //       request: true,
    //       compact: true,
    //       maxWidth: 50),
    // );
    _dio.interceptors.add(AuthInterceptor(onUnauthorized: () {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginPage.routeName,
        (route) => false,
      );
    }));
  }

  Map<String, String> _headers() {
    return {
      'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
      'Content-Type': 'application/json',
      "Accept": 'application/json',
      "Accept-Charset": "application/json",
      "Accept-Language": lang,
    };
  }

  Future<Response> get({required String endPoint}) {
    return _dio.get(endPoint, options: Options(headers: _headers()));
  }

  Future<Response> post({required String endPoint, required dynamic data}) {
    return _dio.post(endPoint,
        data: data, options: Options(headers: _headers()));
  }

  Future<Response> put({required String endPoint, required dynamic data}) {
    return _dio.put(endPoint,
        data: data, options: Options(headers: _headers()));
  }

  Future<Response> delete({required String endPoint}) {
    return _dio.delete(endPoint, options: Options(headers: _headers()));
  }
}
