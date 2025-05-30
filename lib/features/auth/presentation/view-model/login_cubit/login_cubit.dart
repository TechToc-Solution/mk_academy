import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/auth/data/repos/login_repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginInitial());

  Future login({required String pass, required String phone}) async {
    emit(LoginLoading());
    var resp = await _loginRepo.login(pass, phone);
    resp.fold((failure) {
      emit(LoginError(errorMsg: failure.message));
    }, (user) {
      emit(LoginSuccess());
    });
  }
}
