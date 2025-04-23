part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

final class RegisterFailure extends RegisterState {
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

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}
