import 'package:equatable/equatable.dart';

sealed class DownloadHandlerState extends Equatable {
  const DownloadHandlerState();

  @override
  List<Object> get props => [];
}

final class DownloadHandlerInitial extends DownloadHandlerState {}

final class DownloadHandlerError extends DownloadHandlerState {
  final int id;
  final String errorMsg;

  const DownloadHandlerError({required this.errorMsg, required this.id});
}

final class DownloadHandlerSuccess extends DownloadHandlerState {
  final int id;
  final String? filePath;

  const DownloadHandlerSuccess({required this.filePath, required this.id});
}

final class DownloadHandlerLoding extends DownloadHandlerState {
  final int id;

  const DownloadHandlerLoding({required this.id});
}

final class DownloadHandlerDenied extends DownloadHandlerState {
  final int id;

  const DownloadHandlerDenied({required this.id});
}
