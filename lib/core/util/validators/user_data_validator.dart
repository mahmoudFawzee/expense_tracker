import 'package:expense_tracker/core/util/validators/email_validator.dart';
import 'package:expense_tracker/core/util/validators/form_validator.dart';
import 'package:expense_tracker/core/util/validators/text_field_validator.dart';
import 'package:flutter/material.dart';

class UserDataValidator {
  final _formValidator = FormValidator();
  GlobalKey<FormState> get formKey => _formValidator.formKey;
  bool validateForm() => _formValidator.validateForm();
  final _textFieldValidator = const TextFieldValidator();
  final _emailValidator = EmailValidator();
  TextEditingController get emailController => _emailValidator.emailController;
  //?email holder
  String? get email => _emailValidator.email;

  final firstNameController = TextEditingController();
  //?first name holder
  String? _firstName;
  String? get firstName => _firstName;
  final lastNameController = TextEditingController();
  //?last name holder
  String? _lastName;
  String? get lastName => _lastName;
  final phoneNumberController = TextEditingController();
  //?phone number holder
  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;
  //?validate first name
  String? validateFirstName(BuildContext context, {required String? value}) {
    //?reset first name
    _firstName = null;
    final result = _textFieldValidator.validateName(context, value);
    if (result == null) _firstName = value;
    return result;
  }

  //?validate last name
  String? validateLastName(BuildContext context, {required String? value}) {
    //?reset last name
    _lastName = null;
    final result = _textFieldValidator.validateName(context, value);
    if (result == null) _lastName = value;
    return result;
  }

  //?validate phone number
  String? validatePhoneNumber(BuildContext context, {required String? value}) {
    //?reset phone number
    _phoneNumber = null;
    final result = _textFieldValidator.validatePhoneNumber(context, value);
    if (result == null) _phoneNumber = value;
    return result;
  }

  String? validateEmail(BuildContext context, {required String? value}) =>
      _emailValidator.validateEmail(context, value: value);

  void setFieldsValues({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
  }) {
    firstNameController.text = firstName ?? '';
    lastNameController.text = lastName ?? '';
    phoneNumberController.text = phoneNumber ?? '';
    _emailValidator.setFieldsValues(
      email: email,
    );
  }

//?dispose controllers
  void dispose() {
    _emailValidator.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
  }
}
