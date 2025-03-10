import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/profile/data/repos/profile_repo.dart';

import '../../../auth/data/models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepo) : super(ProfileInitial());
  final ProfileRepo _profileRepo;
  Future getProfile() async {
    emit(ProfileLoading());
    var data = await _profileRepo.getUserProfile();
    data.fold((error) => emit(ProfileError(errorMsg: error)), (user) {
      emit(ProfileSuccess(userModel: user));
    });
  }
}
