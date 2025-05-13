import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expense_tracker/config/theme/color_manger.dart';
import 'package:flutter/material.dart';

class CustomAwesomeDialog {
  const CustomAwesomeDialog();
  static void showDialog({
    required BuildContext context,
    required String title,
    Widget? body,
    required Function()? btnCancelOnPress,
    required Function()? btnOkOnPress,
  }) async {
    AwesomeDialog(
      autoDismiss: false,
      onDismissCallback: (type) {
        log('dismiss type: $type');
        if (type == DismissType.btnOk) {
          return;
        }        
      },
      context: context,
      dialogBackgroundColor: ColorsMangerDark.primaryColor,
      dialogType: DialogType.warning,
      body: body,
      title: title,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
    ).show();
  }
}
