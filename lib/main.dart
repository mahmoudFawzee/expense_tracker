import 'package:expense_tracker/app/cubits/localization_cubit.dart';
import 'package:expense_tracker/app/cubits/navigation_cubit.dart';
import 'package:expense_tracker/app/cubits/theme_cubit.dart';
import 'package:expense_tracker/presentation/routes/routes_manger.dart';
import 'package:expense_tracker/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationCubit>(
          create: (context) => LocalizationCubit()..getLocalization(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit()..isDarkTheme(),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDark) {
          return BlocBuilder<LocalizationCubit, String>(
            builder: (context, langState) {
              return MaterialApp.router(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                routerConfig: router,
                locale: Locale(langState),
                theme: getTheme(isDark),
              );
            },
          );
        },
      ),
    );
  }
}
