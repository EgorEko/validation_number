part of 'validation_cubit_cubit.dart';

abstract class ValidationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ValidationStateInitial extends ValidationState {}

class ValidationStateInProcess extends ValidationState {
  final String digits;

  ValidationStateInProcess(this.digits);

  @override
  List<Object?> get props => [digits];
}

class ValidationStateSucceeded extends ValidationState {
  final String phoneNumber;

  ValidationStateSucceeded(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}
