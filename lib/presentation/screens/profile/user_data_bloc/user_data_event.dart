part of 'user_data_bloc.dart';

sealed class UserDataEvent extends Equatable {
  const UserDataEvent({ required this.calledFrom});
  final String calledFrom;
  @override
  List<Object?> get props => [calledFrom];
}

final class FetchUserDataEvent extends UserDataEvent {
  const FetchUserDataEvent({required super.calledFrom});
}

final class UpdateUserDateEvent extends UserDataEvent {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  const UpdateUserDateEvent({required super.calledFrom,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });
  @override
  List<Object?> get props => [firstName, lastName, email, phoneNumber];
}

final class DeleteAccountEvent extends UserDataEvent {
  final String password;
  const DeleteAccountEvent(this.password, {required super.calledFrom});
  @override
  List<Object> get props => [password];
}

final class ConfirmUserDeleteEvent extends UserDataEvent {
  final String password;
  const ConfirmUserDeleteEvent(this.password, {required super.calledFrom});
  @override
  List<Object> get props => [password];
}

final class ConfirmUpdateEmailEvent extends UserDataEvent {
  final UserModel user;
  final String password;
  const ConfirmUpdateEmailEvent(this.user, this.password,
      {required super.calledFrom});
  @override
  List<Object> get props => [user, password];
}


