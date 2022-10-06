import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'validation_cubit_state.dart';

class ValidationCubit extends Cubit<ValidationState> {
  ValidationCubit() : super(ValidationStateInitial());

  Future<void> activateFAB(String phoneNumber) async {
    if (state is ValidationStateInitial) {
      if (phoneNumber.isNotEmpty) {
        emit(ValidationStateInProcess(phoneNumber));
      }
    }
    if (state is ValidationStateInProcess && phoneNumber.length == 14) {
      emit(ValidationStateSucceeded(phoneNumber));
    }
    if (state is ValidationStateSucceeded && phoneNumber.length < 14) {
      emit(ValidationStateInProcess(phoneNumber));
    }
  }
}
