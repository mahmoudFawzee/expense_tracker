import 'package:expense_tracker/presentation/screens/auth/base_validator.dart';
import 'package:flutter/widgets.dart';

final class RegisterValidator extends BaseValidator {
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
  final confirmPasswordController = TextEditingController();
  //?confirm password holder
  String? _confirmedPassword;
  String? get confirmedPassword => _confirmedPassword;

  //?validate first name
  String? validateFirstName(BuildContext context, {required String? value}) {
    //?reset first name
    _firstName = null;
    final result = super.textFieldValidator.validateName(context, value);
    if (result == null) _firstName = value;
    return result;
  }

  //?validate last name
  String? validateLastName(BuildContext context, {required String? value}) {
    //?reset last name
    _lastName = null;
    final result = super.textFieldValidator.validateName(context, value);
    if (result == null) _lastName = value;
    return result;
  }

  //?validate phone number
  String? validatePhoneNumber(BuildContext context, {required String? value}) {
    //?reset phone number
    _phoneNumber = null;
    final result = super.textFieldValidator.validatePhoneNumber(context, value);
    if (result == null) _phoneNumber = value;
    return result;
  }

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

  //?dispose controllers
  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    confirmPasswordController.dispose();
  }
}
