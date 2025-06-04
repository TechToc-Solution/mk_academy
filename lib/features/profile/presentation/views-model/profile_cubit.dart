import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/profile/data/repos/profile_repo.dart';

import '../../../auth/data/models/user_model.dart';
import '../params/update_profile_params.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepo) : super(ProfileInitial());
  final ProfileRepo _profileRepo;
  UserModel? userModel;
  Future getProfile() async {
    emit(ProfileLoading());
    var data = await _profileRepo.getUserProfile();
    data.fold((failure) => emit(ProfileError(errorMsg: failure.message)),
        (user) {
      userModel = user;
      emit(ProfileSuccess(userModel: user));
    });
  }

  Future updateProfile(UpdateProfileParams params) async {
    emit(ProfileUpdateLoading());
    var data = await _profileRepo.updateUserProfile(params);
    data.fold((failure) => emit(ProfileUpdateError(errorMsg: failure.message)),
        (user) {
      userModel = user;
      emit(ProfileUpdateSuccess(userModel: user));
    });
  }
}
