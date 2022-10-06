import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'validation_cubit_state.dart';

class ValidationCubit extends Cubit<ValidationState> {
  ValidationCubit() : super(ValidationStateInitial());

  Future<void> validatePhoneNumber(String phoneNumber) async {
    if (phoneNumber.isNotEmpty && phoneNumber.length < 3) {
      final String number = '( $phoneNumber';
      emit(ValidationStateInProcess(number));
    }
    if (phoneNumber.length == 3) {
      final String number = '( $phoneNumber )';
      emit(ValidationStateInProcess(number));
    }
    if (phoneNumber.length > 3 && phoneNumber.length < 6) {
      final String number =
          '(${phoneNumber.substring(0, 2)})${phoneNumber.substring(3, 5)}';
      emit(ValidationStateInProcess(number));
    }
    if (phoneNumber.length == 6) {
      final String number =
          '(${phoneNumber.substring(0, 2)})${phoneNumber.substring(3, 5)}-';
      emit(ValidationStateInProcess(number));
    }
    if (phoneNumber.length > 6) {
      final String number =
          '(${phoneNumber.substring(0, 2)})${phoneNumber.substring(3, 5)}-${phoneNumber.substring(6)}';
      emit(ValidationStateSucceeded(number));
    }
  }
}
