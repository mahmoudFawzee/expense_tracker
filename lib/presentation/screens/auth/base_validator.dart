import 'package:flutter/widgets.dart';
import 'package:expense_tracker/presentation/functions/text_field_validator.dart';

class BaseValidator {  
  final _textFieldValidator = const TextFieldValidator();
  TextFieldValidator get textFieldValidator => _textFieldValidator;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  //?set of common controllers
  final emailController = TextEditingController();
  //?email holder
  String? _email;
  String? get email => _email;
  final passwordController = TextEditingController();
  //?password holder
  String? _password;
  String? get password => _password;
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

  //?validate password
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

  //?validate form
  bool validateForm() {
    final valid = _formKey.currentState?.validate();
    if (valid == null) return false;
    return valid;
  }

  //?dispose controllers
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
