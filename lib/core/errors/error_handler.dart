import 'package:dio/dio.dart';
import 'dart:io';

import '../utils/constats.dart';

class ErrorHandler {
  static const Map<String, String> _enMessages = {
    "connectionTimeout": "Connection timeout with the server.",
    "sendTimeout": "Request timeout with the server.",
    "receiveTimeout": "The server is not responding.",
    "cancel": "Request was canceled.",
    "noInternet": "No internet connection.",
    "unknownError": "Unknown error occurred.",
    "badCertificate": "Bad certificate error.",
    "connectionError": "No internet connection.",
    "serverError": "Oops, there was an error. Please try again later.",
    "notFound": "The requested resource was not found.",
    "internalServerError": "Internal server error. Please try again later.",
    "validationError": "Invalid input data.",
    "error_tryAgain": "Oops there was an error, please try again later.",
  };

  static const Map<String, String> _arMessages = {
    "connectionTimeout": "انتهت مهلة الاتصال بالخادم",
    "sendTimeout": "انتهت مهلة الطلب للخادم",
    "receiveTimeout": "الخادم لا يستجيب",
    "cancel": "تم إلغاء الطلب",
    "noInternet": "لا يوجد اتصال بالإنترنت",
    "unknownError": "حدث خطأ غير معروف",
    "badCertificate": "خطأ في الشهادة",
    "connectionError": "لا يوجد اتصال بالإنترنت",
    "serverError": "هنالك خطأ ما، الرجاء المحاولة لاحقاً",
    "notFound": "الطلب غير موجود",
    "internalServerError": "خطأ في الخادم، الرجاء المحاولة لاحقاً",
    "validationError": "بيانات غير صالحة",
    "error_tryAgain": "هنالك خطأ ما الرجاء المحاولة لاحقاً",
  };
  static Map<String, String> get _messages =>
      lang == 'en' ? _enMessages : _arMessages;

  static String handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }
    if (error is SocketException) {
      return _messages['noInternet']!;
    }
    return _messages['error_tryAgain']!;
  }

  static String defaultMessage() => _messages['error_tryAgain']!;

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return _messages['connectionTimeout']!;
      case DioExceptionType.sendTimeout:
        return _messages['sendTimeout']!;
      case DioExceptionType.receiveTimeout:
        return _messages['receiveTimeout']!;
      case DioExceptionType.cancel:
        return _messages['cancel']!;
      case DioExceptionType.unknown:
        return error.error is SocketException
            ? _messages['noInternet']!
            : _messages['unknownError']!;
      case DioExceptionType.badCertificate:
        return _messages['badCertificate']!;
      case DioExceptionType.connectionError:
        return _messages['connectionError']!;
      case DioExceptionType.badResponse:
        return _handleResponseError(error);
      default:
        return _messages['error_tryAgain']!;
    }
  }

  static String _handleResponseError(DioException error) {
    final response = error.response;
    if (response == null) return _messages['error_tryAgain']!;

    switch (response.statusCode) {
      case 400:
      case 401:
      case 403:
        return response.data['message'] ?? _messages['error_tryAgain']!;
      case 404:
        return _messages['notFound']!;
      case 422:
        return _handleValidationErrors(response.data);
      case 500:
        return response.data['message'] ?? _messages['internalServerError']!;
      case 503:
        return response.data['message'] ?? _messages['serverError']!;
      default:
        return _messages['serverError']!;
    }
  }

  static String _handleValidationErrors(dynamic data) {
    final errors = (data is Map<String, dynamic>) ? data['message'] : null;
    if (errors is! Map<String, dynamic>) {
      return _messages['validationError']!;
    }

    final messages = errors.values.expand((e) {
      if (e is List) return e.map((v) => v.toString());
      return [e.toString()];
    }).join(', ');

    return messages.isNotEmpty ? messages : _messages['validationError']!;
  }
}
