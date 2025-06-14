part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final UserModel userModel;

  const ProfileSuccess({required this.userModel});
}

final class ProfileError extends ProfileState {
  final String errorMsg;

  const ProfileError({required this.errorMsg});
}

final class ProfileLoading extends ProfileState {}

final class ProfileUpdateSuccess extends ProfileState {
  final UserModel userModel;

  const ProfileUpdateSuccess({required this.userModel});
}

final class ProfileUpdateError extends ProfileState {
  final String errorMsg;

  const ProfileUpdateError({required this.errorMsg});
}

final class ProfileUpdateLoading extends ProfileState {}
