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
  final bool downloaded;

  const DownloadHandlerSuccess(
      {required this.filePath, required this.id, this.downloaded = false});
}

final class DownloadHandlerProgress extends DownloadHandlerState {
  final int id;
  final double progress;

  const DownloadHandlerProgress({required this.id, this.progress = 0.0});

  @override
  List<Object> get props => [progress];
}

final class DownloadHandlerDenied extends DownloadHandlerState {
  final int id;

  const DownloadHandlerDenied({required this.id});
}
