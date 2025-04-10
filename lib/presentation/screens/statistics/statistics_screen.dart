import 'package:expense_tracker/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  static const pageRoute = '/Statistics_page';
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: appLocalizations.statistics),
    );
  }
}
