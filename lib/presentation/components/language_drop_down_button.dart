import 'dart:developer';

import 'package:expense_tracker/app/cubits/localization_cubit.dart';
import 'package:expense_tracker/data/constants/lang_code.dart';
import 'package:expense_tracker/presentation/components/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageDropDownButton extends StatelessWidget {
  const LanguageDropDownButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return DropdownButton<String>(
      iconEnabledColor: Theme.of(context).textTheme.labelLarge!.color,
      hint: BlocBuilder<LocalizationCubit, String>(
        builder: (context, state) {
          return Text(
            langCodeList[state]!,
            style: Theme.of(context).textTheme.labelLarge,
          );
        },
      ),
      items: langCodeList.keys.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            langCodeList[item]!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
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
    );
  }
}
