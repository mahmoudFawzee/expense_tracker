import 'package:expense_tracker/core/util/validators/password_validator.dart';
import 'package:flutter/material.dart';

class ConfirmPassValidator extends PasswordValidator {
  final confirmPasswordController = TextEditingController();
  //?confirm password holder
  String? _confirmedPassword;
  String? get confirmedPassword => _confirmedPassword;

  //?validate confirm password
  String? validateConfirmPassword(BuildContext context, String? value) {
    //?reset confirm password
    _confirmedPassword = null;
    final result = super
        .textFieldValidator
        .confirmPassword(context, super.passwordController.text, value);
    if (result == null) _confirmedPassword = value;
    return result;
  }

  @override
  void setFieldsValues({String? password, String? confirmPassword}) {
    confirmPasswordController.text = confirmPassword!;
    super.setFieldsValues(password: password);
  }

  // //?dispose controllers
  @override
  void dispose() {
    super.dispose();
    confirmPasswordController.dispose();
  }
}
