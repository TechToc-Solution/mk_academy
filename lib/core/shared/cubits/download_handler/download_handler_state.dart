import 'package:equatable/equatable.dart';

sealed class DownloadHandlerState extends Equatable {
  const DownloadHandlerState();

  @override
  List<Object> get props => [];
}

final class DownloadHandlerInitial extends DownloadHandlerState {}

final class DownloadHandlerError extends DownloadHandlerState {
  final String errorMsg;

  const DownloadHandlerError({required this.errorMsg});
}

final class DownloadHandlerSuccess extends DownloadHandlerState {
  final String? filePath;

  const DownloadHandlerSuccess({required this.filePath});
}

final class DownloadHandlerLoding extends DownloadHandlerState {}

final class DownloadHandlerDenied extends DownloadHandlerState {}
