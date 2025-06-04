// download_manager_state.dart
part of 'download_manager_cubit.dart';

class DownloadManagerState extends Equatable {
  /// Keyed by "$videoId-$quality".
  final Map<String, DownloadTask> tasks;

  const DownloadManagerState({this.tasks = const {}});

  DownloadManagerState copyWith({Map<String, DownloadTask>? tasks}) {
    return DownloadManagerState(tasks: tasks ?? this.tasks);
  }

  @override
  List<Object?> get props => [tasks];
}
