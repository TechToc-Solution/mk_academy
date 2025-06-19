// download_manager_state.dart
part of 'download_manager_cubit.dart';

abstract class DownloadManagerState extends Equatable {
  final Map<String, DownloadTaskInfo> tasks;

  const DownloadManagerState({required this.tasks});
  @override
  List<Object> get props => [tasks];
}

class DownloadInitial extends DownloadManagerState {
  DownloadInitial() : super(tasks: {});
}

class DownloadUpdated extends DownloadManagerState {
  const DownloadUpdated({required super.tasks});
}
