part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class LoginSuccessState extends AuthState {
  const LoginSuccessState();
}

final class LogoutSuccessState extends AuthState {
  const LogoutSuccessState();
}

final class RegisterSuccessState extends AuthState {
  const RegisterSuccessState();
}

sealed class AuthError extends AuthState {
  final String error;
  const AuthError(this.error);
  @override
  List<Object> get props => [error];
}

final class RegisterFailure extends AuthState {
  const RegisterFailure({
    this.firstNameError,
    this.lastNameError,
    this.phoneNumberError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.error,
  });
  final String? firstNameError;
  final String? lastNameError;
  final String? phoneNumberError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  //?this is unknown error like network error
  final String? error;

  @override
  List<Object?> get props => [
        firstNameError,
        lastNameError,
        phoneNumberError,
        emailError,
        passwordError,
        confirmPasswordError,
        error,
      ];
}

final class LogoutErrorState extends AuthError {
  const LogoutErrorState(super.error);
}

final class LoginFailureState extends AuthState {
  final String? emailError;
  final String? passwordError;
  final String? error;

  const LoginFailureState({
    this.emailError,
    this.passwordError,
    this.error,
  });

  @override
  List<Object?> get props => [emailError, passwordError, error];
}

final class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}
