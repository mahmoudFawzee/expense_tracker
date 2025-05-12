import 'package:expense_tracker/core/util/validators/confirm_pass_validator.dart';
import 'package:expense_tracker/core/util/validators/form_validator.dart';
import 'package:expense_tracker/core/util/validators/user_data_validator.dart';
import 'package:flutter/widgets.dart';

final class RegisterValidator {
  final _formValidator = FormValidator();
  GlobalKey<FormState> get formKey => _formValidator.formKey;
  bool validateForm() => _formValidator.validateForm();
  final _userDataValidator = UserDataValidator();
  final _confirmPassValidator = ConfirmPassValidator();

  TextEditingController get passwordController =>
      _confirmPassValidator.passwordController;
  String? get password => _confirmPassValidator.password;

  //?confirm password holder
  TextEditingController get confirmPasswordController =>
      _confirmPassValidator.confirmPasswordController;
  String? get confirmedPassword => _confirmPassValidator.confirmedPassword;

  TextEditingController get emailController =>
      _userDataValidator.emailController;
  //?email holder
  String? get email => _userDataValidator.email;

  TextEditingController get firstNameController =>
      _userDataValidator.firstNameController;
  String? get firstName => _userDataValidator.firstName;

  TextEditingController get lastNameController =>
      _userDataValidator.lastNameController;
  String? get lastName => _userDataValidator.lastName;

  TextEditingController get phoneNumberController =>
      _userDataValidator.phoneNumberController;
  String? get phoneNumber => _userDataValidator.phoneNumber;

  String? validatePassword(BuildContext context, String? value) =>
      _confirmPassValidator.validatePassword(
        context,
        value: value,
      );
  //?validate confirm password
  String? validateConfirmPassword(BuildContext context, String? value) =>
      _confirmPassValidator.validateConfirmPassword(
        context,
        value,
      );
  //?validate first name
  String? validateFirstName(BuildContext context, {required String? value}) =>
      _userDataValidator.validateFirstName(context, value: value);

  //?validate last name
  String? validateLastName(BuildContext context, {required String? value}) =>
      _userDataValidator.validateLastName(context, value: value);

  //?validate phone number
  String? validatePhoneNumber(BuildContext context, {required String? value}) =>
      _userDataValidator.validatePhoneNumber(context, value: value);

  String? validateEmail(BuildContext context, {required String? value}) =>
      _userDataValidator.validateEmail(context, value: value);

  void setFieldsValues({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
  }) =>
      _userDataValidator.setFieldsValues(
        firstName: firstName,
        lastName: lastName,
        email: phoneNumber,
        phoneNumber: email,
      );

  //?dispose controllers
  void dispose() {
    _confirmPassValidator.dispose();
    _userDataValidator.dispose();
  }
}
