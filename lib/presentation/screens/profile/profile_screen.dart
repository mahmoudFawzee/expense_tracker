import 'dart:developer';
import 'package:expense_tracker/app/cubits/theme_cubit.dart';
import 'package:expense_tracker/presentation/components/app_bar/underlayer_app_bar.dart';
import 'package:expense_tracker/presentation/components/custom_list_tile.dart';
import 'package:expense_tracker/presentation/components/language_drop_down_button.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const pageRoute = '/Profile_page';
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
        top: height * .1,
      ),
      child: StatisticsCard(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<ThemeCubit, bool>(
                      builder: (context, isDark) {
                        return IconButton(
                          onPressed: () {
                            context
                                .read<ThemeCubit>()
                                .setTheme(isDark: !isDark);
                          },
                          icon: Icon(
                            isDark ? Icons.dark_mode : Icons.light_mode,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      size: 125,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      'Ali Fawzy',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomListTile(
                      leadingIcon: Icons.person,
                      label: appLocalizations.profile,
                      onTap: () {
                        log('profile');
                      },
                    ),
                    CustomListTile(
                      leadingIcon: Icons.key,
                      label: appLocalizations.changePassword,
                      onTap: () {
                        log('change password');
                      },
                    ),
                    CustomListTile(
                      leadingIcon: Icons.language,
                      label: appLocalizations.language,
                      trailing: const LanguageDropDownButton(),
                      onTap: () {
                        log('change lang');
                      },
                    ),
                    CustomListTile(
                      leadingIcon: Icons.info_outlined,
                      label: appLocalizations.about,
                      onTap: () {
                        log('about');
                      },
                    ),
                    CustomListTile(
                      leadingIcon: Icons.privacy_tip_outlined,
                      label: appLocalizations.privacyPolicy,
                      onTap: () {
                        log('privacy');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
