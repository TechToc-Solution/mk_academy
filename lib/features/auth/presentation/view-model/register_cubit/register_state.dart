part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class GetCitiesSuccess extends RegisterState {}

final class GetCitiesError extends RegisterState {
  final String errorMsg;

  GetCitiesError({required this.errorMsg});
}

final class RegisterSuccess extends RegisterState {
  final String phoneNum;

  RegisterSuccess({required this.phoneNum});
}

final class RegisterLoading extends RegisterState {}

final class RegisterError extends RegisterState {
  final String errorMsg;

  RegisterError({required this.errorMsg});
}

final class VerifiPhoneSuccess extends RegisterState {
  final UserModel user;

  VerifiPhoneSuccess({required this.user});
}

final class VerifiPhoneLoading extends RegisterState {}

final class VerifiPhoneError extends RegisterState {
  final String errorMsg;

  VerifiPhoneError({required this.errorMsg});
}
