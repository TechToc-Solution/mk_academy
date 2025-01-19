import 'package:dio/dio.dart';

class ApiServices {
  final _basUrl = 'https://www.googleapis.com/books/v1/';
  final Dio _dio;
  ApiServices(
    this._dio,
  );
  Future<Map<String, dynamic>> get({required endPoint}) async {
    var response = await _dio.get('$_basUrl$endPoint');
    return response.data;
  }
}
