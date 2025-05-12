part of 'change_password_cubit.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
}

final class ChangePasswordFailed extends ChangePasswordState {
  final String? newPasswordError;
  final String? newPasswordConfirmationError;
  final String? oldPasswordError;
  final String? globalError;
  const ChangePasswordFailed({
    this.newPasswordConfirmationError,
    this.newPasswordError,
    this.oldPasswordError,
    this.globalError,
  });
  @override
  List<Object?> get props => [
        newPasswordConfirmationError,
        oldPasswordError,
        newPasswordError,
        globalError,
      ];
}

final class ChangePasswordSucceeded extends ChangePasswordState {
  const ChangePasswordSucceeded();
}

final class ChangePasswordLoadingState extends ChangePasswordState {
  const ChangePasswordLoadingState();
}
