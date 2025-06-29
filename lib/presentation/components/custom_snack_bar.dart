import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context, {
  required String value,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(value)));
}
