import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repos/pay/pay_repo.dart';
import 'pay_state.dart';

class PayCubit extends Cubit<PayState> {
  final PayRepo _payRepo;

  PayCubit(this._payRepo) : super(PayInitial());

  Future<void> payCourse( String code) async {
    emit(PayLoading());

    final result = await _payRepo.payCourse(code);

    result.fold(
      (failure) => emit(PayError(failure.message)),
      (_) => emit(PaySuccess()),
    );
  }

  Future<void> checkCode(String code) async {
    emit(CheckLoading());

    final result = await _payRepo.getCodeData(code: code);

    result.fold(
      (failure) => emit(CheckError(failure.message)),
      (courses) => emit(CheckSuccess(courses: courses)),
    );
  }
}
