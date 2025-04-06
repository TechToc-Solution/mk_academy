import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/delete_account_repo.dart/delete_account_repo.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final DeleteAccountRepo _repo;

  DeleteAccountCubit(this._repo) : super(DeleteAccountInitial());

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());

    final result = await _repo.deleteAccount();

    result.fold(
      (failure) => emit(DeleteAccountError(failure.message)),
      (_) => emit(DeleteAccountSuccess()),
    );
  }
}
