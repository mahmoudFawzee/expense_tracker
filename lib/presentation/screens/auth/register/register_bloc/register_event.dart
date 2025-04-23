part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class CreateAccountEvent extends RegisterEvent {
  const CreateAccountEvent({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  List<Object> get props => [
        firstName,
        lastName,
        phoneNumber,
        email,
        password,
        confirmPassword,
      ];
}
