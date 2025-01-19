import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailuer extends Failure {
  ServerFailuer({required super.errorMessage});

  factory ServerFailuer.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailuer(errorMessage: 'Connection timeoute with server');
      case DioExceptionType.sendTimeout:
        return ServerFailuer(errorMessage: 'Send timeoute with server');
      case DioExceptionType.receiveTimeout:
        return ServerFailuer(errorMessage: 'Receive timeoute with server');
      case DioExceptionType.badCertificate:
        return ServerFailuer(errorMessage: dioException.message!);
      case DioExceptionType.badResponse:
        return ServerFailuer.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailuer(
            errorMessage: 'The request to the server was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailuer(
            errorMessage:
                'Connection error pleas check your connection and try agean');
      case DioExceptionType.unknown:
        return ServerFailuer(errorMessage: 'Unknown error, pleas try letar');
      default:
        return ServerFailuer(
            errorMessage: 'Opps there is was an error , pleas try later');
    }
  }

  factory ServerFailuer.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailuer(errorMessage: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailuer(
          errorMessage: 'your requst not found , pleas try later');
    } else if (statusCode == 500) {
      return ServerFailuer(
          errorMessage: 'Internal server error , pleas try later');
    } else {
      return ServerFailuer(
          errorMessage: 'Opps there is was an error , pleas try later');
    }
  }
}
