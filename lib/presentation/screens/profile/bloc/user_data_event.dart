part of 'user_data_bloc.dart';

sealed class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

final class FetchUserDataEvent extends UserDataEvent {
  const FetchUserDataEvent();
}

final class UpdateUserDateEvent extends UserDataEvent {
  final UserModel user;
  const UpdateUserDateEvent(this.user);
  @override
  List<Object> get props => [user];
}

final class DeleteAccountEvent extends UserDataEvent {
  final String password;
  const DeleteAccountEvent(this.password);
  @override
  List<Object> get props => [password];
}

final class ConfirmUserDeleteEvent extends UserDataEvent {
  final String password;
  const ConfirmUserDeleteEvent(this.password);
  @override
  List<Object> get props => [password];
}

final class ConfirmUpdateEmailEvent extends UserDataEvent {
  final UserModel user;
  final String password;
  const ConfirmUpdateEmailEvent(this.user, this.password);
  @override
  List<Object> get props => [user, password];
}
