import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final _emailRegExp = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);
final _nameRegExp = RegExp(r'^[a-zA-Z\s\-]+$');
final _phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');
final _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&^()\-_=+])[A-Za-z\d@$!%*#?&^()\-_=+]{8,}$');

AppLocalizations _appLocalizations(BuildContext context) =>
    AppLocalizations.of(context)!;

bool _isNullOrEmpty(String? value) {
  if (value == null) return true;
  return value.isEmpty;
}

String _emptyValue(BuildContext context, String parameter) {
  return _appLocalizations(context).canNotEmpty(parameter);
}

String _unValid(BuildContext context, String parameter) {
  return _appLocalizations(context).unValid(parameter);
}

String _notMatched(BuildContext context, String parameter) {
  return _appLocalizations(context).notMatched(parameter);
}

String? validateName(
  BuildContext context,
  String? value,
) {
  if (_isNullOrEmpty(value)) {
    return _emptyValue(context, _appLocalizations(context).name);
  }
  if (!_nameRegExp.hasMatch(value!)) {
    return _unValid(context, _appLocalizations(context).name);
  }
  return null;
}

String? validateEmail(
  BuildContext context,
  String? value,
) {
  if (_isNullOrEmpty(value)) {
    return _emptyValue(context, _appLocalizations(context).email);
  }

  if (!_emailRegExp.hasMatch(value!)) {
    return _unValid(context, _appLocalizations(context).email);
  }
  return null;
}

String? validatePhoneNumber(
  BuildContext context,
  String? value,
) {
  if (_isNullOrEmpty(value)) {
    return _emptyValue(context, _appLocalizations(context).phone_number);
  }
  if (!_phoneRegExp.hasMatch(value!)) {
    return _unValid(context, _appLocalizations(context).phone_number);
  }
  return null;
}

String? validatePassword(
  BuildContext context,
  String? value,
) {
  if (_isNullOrEmpty(value)) {
    return _emptyValue(context, _appLocalizations(context).password);
  }
  if (value!.length < 8) {
    return _appLocalizations(context).isTooShort;
  }
  if (!_passwordRegExp.hasMatch(value)) {
    return _appLocalizations(context).pass_not_valid;
  }
  return null;
}

String? confirmPassword(
  BuildContext context,
  String? originalPass,
  String? value,
) {
  if (_isNullOrEmpty(value)) {
    return _emptyValue(context, _appLocalizations(context).password);
  }
  if (value != originalPass) {
    return _notMatched(context, _appLocalizations(context).password);
  }
  return null;
}
