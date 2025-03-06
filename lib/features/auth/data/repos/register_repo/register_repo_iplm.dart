import 'package:dartz/dartz.dart';
import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/Api_services/urls.dart';
import 'package:mk_academy/core/errors/error_handler.dart';
import 'package:mk_academy/features/auth/data/models/city_model.dart';
import 'package:mk_academy/features/auth/data/repos/register_repo/register_repo.dart';

class RegisterRepoIplm implements RegisterRepo {
  final ApiServices _apiServices;

  RegisterRepoIplm(this._apiServices);

  @override
  Future<Either<String, List<City>>> getCities() async {
    try {
      var resp = await _apiServices.get(endPoint: Urls.getCities);
      List<City> cities = [];
      if (resp.statusCode == 200 && resp.data['success']) {
        for (var city in resp.data['data']) {
          cities.add(City.fromJson(city));
        }
      }
      return right(cities);
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<String, String>> register(Map<String, String> registerData) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
