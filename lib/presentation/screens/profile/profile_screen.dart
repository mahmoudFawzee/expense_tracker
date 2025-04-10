import 'package:expense_tracker/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const pageRoute = '/Profile_page';
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return  Scaffold(
      appBar: CustomAppBar(title: appLocalizations.profile),
    );
  }
}
