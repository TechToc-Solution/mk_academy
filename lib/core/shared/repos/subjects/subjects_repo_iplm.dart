// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:mk_academy/core/Api_services/api_services.dart';
import 'package:mk_academy/core/shared/models/subjects_model.dart';

import '../../../Api_services/urls.dart';
import '../../../errors/error_handler.dart';
import '../../../errors/failuer.dart';
import 'subjects_repo.dart';

class subjectsRepoIplm implements subjectsRepo {
  ApiServices _apiServices;
  subjectsRepoIplm(
    this._apiServices,
  );
  @override
  Future<Either<Failure, SubjectsModel>> getSubjects() async {
    try {
      var resp = await _apiServices.get(endPoint: Urls.getSubjects);
      if (resp.statusCode == 200 && resp.data['success']) {
        return right(SubjectsModel.fromJson(resp.data));
      }
      return left(
          ServerFailure(resp.data['message'] ?? ErrorHandler.defaultMessage()));
    } catch (e) {
      return left(ErrorHandler.handle(e));
    }
  }
}
