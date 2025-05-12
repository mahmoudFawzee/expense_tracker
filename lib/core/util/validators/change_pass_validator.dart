import 'package:expense_tracker/core/util/validators/confirm_pass_validator.dart';
import 'package:expense_tracker/core/util/validators/form_validator.dart';
import 'package:expense_tracker/core/util/validators/password_validator.dart';
import 'package:flutter/widgets.dart';

final class ChangePasswordValidator {
  final _formValidator = FormValidator();
  GlobalKey<FormState> get formKey => _formValidator.formKey;
  bool validateForm() => _formValidator.validateForm();
  final _confirmPassValidator = ConfirmPassValidator();
  final _passwordValidator = PasswordValidator();

  TextEditingController get oldPassController =>
      _passwordValidator.passwordController;
  String? get oldPassword => _passwordValidator.password;
  String? validateOldPassword(BuildContext context, String? value) =>
      _passwordValidator.validatePassword(context, value: value);

  TextEditingController get newPassController =>
      _confirmPassValidator.passwordController;
  String? get newPassword => _confirmPassValidator.password;
  String? validateNewPassword(BuildContext context, String? value) =>
      _confirmPassValidator.validatePassword(context, value: value);

  TextEditingController get confirmNewPassController =>
      _confirmPassValidator.confirmPasswordController;
  String? get confirmNewPassword => _confirmPassValidator.confirmedPassword;
  String? validateConfirmNewPassword(BuildContext context, String? value) =>
      _confirmPassValidator.validateConfirmPassword(context, value);

  dispose() {
    _confirmPassValidator.dispose();
    _passwordValidator.dispose();
  }
}
