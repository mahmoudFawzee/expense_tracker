import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  void login(
    String email,
    String password,
  ) async {
    emit(const LoginLoadingState());
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (email.isNotEmpty) {
        emit(const LoginSuccess());
        return;
      }
      emit(const LoginFailure(
        emailError: 'this email does not exist',
        passwordError: 'password is not correct',
      ));
    } catch (e) {
      emit(const LoginFailure(
        emailError: 'An error occurred',
        passwordError: 'An error occurred',
      ));
    }
  }
}
