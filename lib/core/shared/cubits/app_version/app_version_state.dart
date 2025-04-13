import 'package:equatable/equatable.dart';

abstract class AppVersionState extends Equatable {
  const AppVersionState();

  @override
  List<Object?> get props => [];
}

class AppVersionInitial extends AppVersionState {}

class AppVersionLoading extends AppVersionState {}

class AppVersionInRange extends AppVersionState {}

class AppVersionOutdated extends AppVersionState {}

class AppVersionUnsupported extends AppVersionState {}

class AppVersionError extends AppVersionState {
  final String message;

  const AppVersionError(this.message);

  @override
  List<Object?> get props => [message];
}
