import 'package:equatable/equatable.dart';

sealed class DownloadHandlerState extends Equatable {
  const DownloadHandlerState();

  @override
  List<Object> get props => [];
}

final class DownloadHandlerInitial extends DownloadHandlerState {}
