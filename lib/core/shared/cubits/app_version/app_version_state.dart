import 'package:equatable/equatable.dart';
import 'package:mk_academy/core/shared/models/version_model.dart';

abstract class AppVersionState extends Equatable {
  const AppVersionState();

  @override
  List<Object?> get props => [];
}

class AppVersionInitial extends AppVersionState {}

class AppVersionLoading extends AppVersionState {}

class AppVersionInRange extends AppVersionState {}

class AppVersionOutdated extends AppVersionState {
  final VersionModel version;

  const AppVersionOutdated({required this.version});
}

class AppVersionUnsupported extends AppVersionState {
  final VersionModel version;

  const AppVersionUnsupported({required this.version});
}

class AppVersionError extends AppVersionState {
  final String message;

  const AppVersionError(this.message);

  @override
  List<Object?> get props => [message];
}
