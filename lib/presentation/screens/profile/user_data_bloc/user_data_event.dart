part of 'user_data_bloc.dart';

sealed class UserDataEvent extends Equatable {
  const UserDataEvent();
  @override
  List<Object?> get props => [];
}

final class FetchUserDataEvent extends UserDataEvent {
  const FetchUserDataEvent();
}

final class UpdateUserDateEvent extends UserDataEvent {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  const UpdateUserDateEvent({    
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
  const DeleteAccountEvent(this.password, );
  @override
  List<Object> get props => [password];
}

final class ConfirmUserDeleteEvent extends UserDataEvent {
  final String password;
  const ConfirmUserDeleteEvent(this.password, );
  @override
  List<Object> get props => [password];
}

final class ConfirmUpdateEmailEvent extends UserDataEvent {
  final UserModel user;
  final String password;
  const ConfirmUpdateEmailEvent(this.user, this.password,
      );
  @override
  List<Object> get props => [user, password];
}

final class DeleteLocalEvent extends UserDataEvent {
  const DeleteLocalEvent();
}
