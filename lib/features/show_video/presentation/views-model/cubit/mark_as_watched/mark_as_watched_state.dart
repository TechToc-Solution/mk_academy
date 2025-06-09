part of 'mark_as_watched_cubit.dart';

enum MarkAsWatchedStatus { initial, loading, success, failure }

class MarkAsWatchedState extends Equatable {
  final MarkAsWatchedStatus status;
  final String? errorMessage;

  const MarkAsWatchedState(
      {this.status = MarkAsWatchedStatus.initial, this.errorMessage});

  @override
  List<Object?> get props => [status, errorMessage];
}
