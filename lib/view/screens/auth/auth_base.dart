import 'dart:developer';

import 'package:expense_tracker/logic/cubits/localization_cubit.dart';
import 'package:expense_tracker/view/components/custom_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/data/constants/lang_code.dart';
import 'package:expense_tracker/view/components/custom_shape.dart';
import 'package:expense_tracker/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthBase extends StatelessWidget {
  const AuthBase({
    super.key,
    required this.child,
  });
  final Widget child;
  static const pageRoute = '/auth_route';

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ClipPath(
              clipper: const CustomShape(),
              child: Container(
                height: 250,
                color: ColorsMangerLight.primaryColor,
              ),
            ),
          ),
          child,
          Positioned(
            right: 20,
            top: 20,
            child: DropdownButton<String>(
              iconEnabledColor: ColorsMangerLight.surface,
              hint: BlocBuilder<LocalizationCubit, String>(
                builder: (context, state) {
                  return Text(
                    langCodeList[state]!,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: ColorsMangerLight.surface,
                        ),
                  );
                },
              ),
              items: langCodeList.keys.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(langCodeList[item]!),
                );
              }).toList(),
              onChanged: (val) {
                log('lang value: $val');
                if (val == null) {
                  showSnackBar(context, value: appLocalizations.someError);
                  return;
                }
                context.read<LocalizationCubit>().setLocalization(val);
              },
            ),
          ),
        ],
      ),
    );
  }
}
