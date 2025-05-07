part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class RegisterEvent extends AuthEvent {
  final UserModel userModel;
  final String password;
  final String confirmPassword;
  const RegisterEvent(this.userModel, this.password,this.confirmPassword);
  @override
  List<Object> get props => [userModel, password,confirmPassword];
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

final class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
