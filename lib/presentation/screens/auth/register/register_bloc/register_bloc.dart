import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterInitial()) {
    on<CreateAccountEvent>((event, emit) async {
      emit(const RegisterLoading());
      try {
        // Simulate a network call
        await Future.delayed(const Duration(seconds: 2));
        emit(const RegisterFailure(
          emailError: "this email already exists",
        ));
      } catch (e) {
        emit(const RegisterFailure(
          error: 'An error occurred',
        ));
      }
    });
  }
}
