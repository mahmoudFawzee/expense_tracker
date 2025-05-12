import 'package:expense_tracker/core/util/validators/form_validator.dart';
import 'package:expense_tracker/core/util/validators/text_field_validator.dart';
import 'package:flutter/material.dart';

class PasswordValidator {
  final _formValidator = FormValidator();
  GlobalKey<FormState> get formKey => _formValidator.formKey;
  bool validateForm() => _formValidator.validateForm();
  final _textFieldValidator = const TextFieldValidator();
  TextFieldValidator get textFieldValidator => _textFieldValidator;

  //?set of common controllers
  final passwordController = TextEditingController();
  //?password holder
  String? _password;
  String? get password => _password;

  String? validatePassword(
    BuildContext context, {
    required String? value,
  }) {
    //?reset password
    _password = null;
    final result = _textFieldValidator.validatePassword(
      context,
      value,
    );
    //?if the result is null, it means the password is valid
    if (result == null) _password = value;
    return result;
  }

  void setFieldsValues({String? password}) {
    passwordController.text = password!;
  }

  //?dispose controllers
  void dispose() {
    passwordController.dispose();
  }
}
