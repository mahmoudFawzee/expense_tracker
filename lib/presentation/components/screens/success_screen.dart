import 'package:expense_tracker/config/theme/color_manger.dart';
import 'package:expense_tracker/presentation/components/screens/base.dart';
import 'package:expense_tracker/config/resources/image_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.btnLabel,
    required this.onTap,
  });
  final String btnLabel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BaseScreen(
      buttonLabel: btnLabel,
      imagePath: ImageManger.success,
      statusText: appLocalizations.success,
      textColor: ColorsMangerDark.successColor,
      onTap: onTap,
    );
  }
}
