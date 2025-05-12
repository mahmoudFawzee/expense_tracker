import 'dart:developer';
import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/models/user/exceptions/user_exception.dart';
import 'package:expense_tracker/data/repositories/user/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final UserDataRepo _userDataRepo;

  ChangePasswordCubit(this._userDataRepo)
      : super(const ChangePasswordInitial());

  Future changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      emit(const ChangePasswordLoadingState());
      final result = await _userDataRepo.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      if (result) {
        emit(const ChangePasswordSucceeded());
      }
    } on UserException catch (e) {
      final errors = e.errors; //Map<String,List>
      log('cubit errors: $errors');
      //cubit errors: {newPassword: [The new password field and old password must be different.]}
      emit(
        ChangePasswordFailed(
          globalError: e.message,
          oldPasswordError: errors?[JsonKeys.oldPassword]?[0],
          newPasswordError: errors?[JsonKeys.newPassword]?[0],
          newPasswordConfirmationError:
              errors?[JsonKeys.newPasswordConfirmation]?[0],
        ),
      );
    } catch (e) {
      emit(ChangePasswordFailed(globalError: e.toString()));
    }
  }
}
