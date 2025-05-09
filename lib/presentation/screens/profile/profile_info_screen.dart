import 'package:expense_tracker/presentation/screens/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});
  static const pageRoute = '/profile_info_screen';

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return HomeBase(
      pageLabel: appLocalizations.profile,
      child: Container(
        color: Colors.red,
        child: const Center(
          child: Text('profile data page'),
        ),
      ),
    );
  }
}
