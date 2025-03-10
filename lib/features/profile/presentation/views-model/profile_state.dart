part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final UserModel userModel;

  ProfileSuccess({required this.userModel});
}

final class ProfileError extends ProfileState {
  final String errorMsg;

  ProfileError({required this.errorMsg});
}

final class ProfileLoading extends ProfileState {}
