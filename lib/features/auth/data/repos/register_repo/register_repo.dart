import 'package:dartz/dartz.dart';
import 'package:mk_academy/features/auth/data/models/city_model.dart';

abstract class RegisterRepo {
  Future<Either<String, String>> register(Map<String, String> registerData);
  Future<Either<String, List<City>>> getCities();
}
