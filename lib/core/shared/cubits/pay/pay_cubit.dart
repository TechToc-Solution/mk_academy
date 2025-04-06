import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repos/pay/pay_repo.dart';
import 'pay_state.dart';

class PayCubit extends Cubit<PayState> {
  final PayRepo _payRepo;

  PayCubit(this._payRepo) : super(PayInitial());

  Future<void> payCourse(int courseId, String code) async {
    emit(PayLoading());

    final result = await _payRepo.payCourse(courseId, code);

    result.fold(
      (failure) => emit(PayError(failure.message)),
      (_) => emit(PaySuccess()),
    );
  }
}
