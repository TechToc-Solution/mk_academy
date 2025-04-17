// pay_state.dart
import 'package:equatable/equatable.dart';
import 'package:mk_academy/features/courses/data/model/courses_model.dart';

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

final class CheckLoading extends PayState {}

final class CheckSuccess extends PayState {
  final List<Courses> courses;

  const CheckSuccess({required this.courses});
}

final class CheckError extends PayState {
  final String message;
  const CheckError(this.message);

  @override
  List<Object> get props => [message];
}
