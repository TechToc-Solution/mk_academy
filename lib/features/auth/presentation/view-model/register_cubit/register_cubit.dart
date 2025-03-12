import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/auth/data/models/city_model.dart';
import 'package:mk_academy/features/auth/data/models/user_model.dart';
import 'package:mk_academy/features/auth/data/repos/register_repo/register_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerRepo) : super(RegisterInitial());

  final RegisterRepo _registerRepo;
  final List<City> cities = [];

  Future getCities() async {
    var data = await _registerRepo.getCities();
    data.fold((failure) => emit(GetCitiesError(errorMsg: failure.message)),
        (newcities) {
      cities.clear();
      cities.addAll(newcities);
      emit(GetCitiesSuccess());
    });
  }

  Future register(Map<String, dynamic> registerData) async {
    emit(RegisterLoading());
    var data = await _registerRepo.register(registerData);
    data.fold((failure) => emit(RegisterError(errorMsg: failure.message)),
        (phoneNum) {
      emit(RegisterSuccess(phoneNum: phoneNum));
    });
  }

  Future verifiPhoneNum({required String phone, required String code}) async {
    emit(VerifiPhoneLoading());
    var data =
        await _registerRepo.verifiPhoneNum(phoneNumber: phone, code: code);
    data.fold((failure) => emit(VerifiPhoneError(errorMsg: failure.message)),
        (user) => emit(VerifiPhoneSuccess(user: user)));
  }
}
