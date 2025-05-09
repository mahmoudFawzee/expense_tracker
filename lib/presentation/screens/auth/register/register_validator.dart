import 'package:expense_tracker/presentation/screens/auth/user_data_validator.dart';
import 'package:flutter/widgets.dart';

final class RegisterValidator extends UserDataValidator {
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

  // //?dispose controllers
  @override
  void dispose() {
    super.dispose();
    confirmPasswordController.dispose();
  }
}
