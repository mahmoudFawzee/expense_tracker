import 'package:expense_tracker/core/util/validators/form_validator.dart';
import 'package:expense_tracker/core/util/validators/text_field_validator.dart';
import 'package:flutter/material.dart';

class EmailValidator {
  final _formValidator = FormValidator();
  GlobalKey<FormState> get formKey => _formValidator.formKey;
  bool validateForm() => _formValidator.validateForm();
  final _textFieldValidator = const TextFieldValidator();
  //?set of common controllers
  final emailController = TextEditingController();
  //?email holder
  String? _email;
  String? get email => _email;
  //?validate email
  String? validateEmail(
    BuildContext context, {
    required String? value,
  }) {
    //?reset email
    _email = null;
    final result = _textFieldValidator.validateEmail(context, value);
    if (result == null) _email = value;
    return result;
  }

  void setFieldsValues({String? email}) {
    emailController.text = email ?? '';
  }

  //?dispose controllers

  void dispose() {
    emailController.dispose();
  }
}
