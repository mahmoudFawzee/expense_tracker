import 'package:expense_tracker/core/util/validators/email_validator.dart';
import 'package:expense_tracker/core/util/validators/form_validator.dart';
import 'package:expense_tracker/core/util/validators/password_validator.dart';
import 'package:flutter/widgets.dart';

class LoginValidator {
  final _formValidator = FormValidator();
  GlobalKey<FormState> get formKey => _formValidator.formKey;
  bool validateForm() => _formValidator.validateForm();
  final _passwordValidator = PasswordValidator();
  final _emailValidator = EmailValidator();

  //?set of common controllers
  TextEditingController get emailController => _emailValidator.emailController;
  TextEditingController get passwordController =>
      _passwordValidator.passwordController;
  //?email holder

  String? get email => _emailValidator.email;
  String? get password => _passwordValidator.password;
  //?validate email
  String? validateEmail(
    BuildContext context, {
    required String? value,
  }) =>
      _emailValidator.validateEmail(context, value: value);

  String? validatePassword(
    BuildContext context, {
    required String? value,
  }) =>
      _passwordValidator.validatePassword(context, value: value);

  void setFieldsValues({String? email}) =>
      _emailValidator.setFieldsValues(email: email);

  //?dispose controllers

  void dispose() {
    _emailValidator.dispose();
    _passwordValidator.dispose();
  }
}
