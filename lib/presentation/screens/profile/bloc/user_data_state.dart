part of 'user_data_bloc.dart';

sealed class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object?> get props => [];
}

final class UserDataInitial extends UserDataState {
  const UserDataInitial();
}

final class UserDataLoadingState extends UserDataState {
  const UserDataLoadingState();
}

final class FetchedUserDataState extends UserDataState {
  final User user;
  const FetchedUserDataState(this.user);
  @override
  List<Object> get props => [user];
}

final class UpdatedUserDataState extends UserDataState {
  const UpdatedUserDataState();
}

final class UpdatedUserEmailState extends UserDataState {
  const UpdatedUserEmailState();
}

final class DeletedUserState extends UserDataState {
  const DeletedUserState();
}

final class AskEmailUpdateConfirmationState extends UserDataState {
  final UserModel user;
  const AskEmailUpdateConfirmationState(this.user);
  @override
  List<Object?> get props => [user];
}

final class UserDateErrorState extends UserDataState {
  final String? firstNameError;
  final String? lastNameError;
  final String? phoneNumberError;
  final String? emailError;
  final String? error;
  const UserDateErrorState({
    this.firstNameError,
    this.lastNameError,
    this.emailError,
    this.phoneNumberError,
    this.error,
  });
  @override
  List<Object?> get props => [
        firstNameError,
        lastNameError,
        emailError,
        phoneNumberError,
        error,
      ];
}
