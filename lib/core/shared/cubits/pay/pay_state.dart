// pay_state.dart
import 'package:equatable/equatable.dart';

sealed class PayState extends Equatable {
  const PayState();

  @override
  List<Object> get props => [];
}

final class PayInitial extends PayState {}

final class PayLoading extends PayState {}

final class PaySuccess extends PayState {}

final class PayError extends PayState {
  final String message;
  const PayError(this.message);

  @override
  List<Object> get props => [message];
}
