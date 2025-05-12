import 'package:flutter/material.dart';

class FormValidator {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  //?validate form
  bool validateForm() {
    final valid = _formKey.currentState?.validate();
    if (valid == null) return false;
    return valid;
  }
}
