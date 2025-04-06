import 'package:expense_tracker/view/theme/color_manger.dart';
import 'package:expense_tracker/view/theme/text_theme.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: ColorsMangerLight.surface,
  appBarTheme: const AppBarTheme(
    color: ColorsMangerLight.surface,
  ),
  primaryColor: ColorsMangerLight.primaryColor,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: ColorsMangerLight.primaryColor,
    onPrimary: Color.fromARGB(255, 16, 69, 61),
    secondary: ColorsMangerLight.accentColor,
    onSecondary: Color.fromARGB(255, 174, 175, 223),
    error: ColorsMangerLight.warningColor,
    onError: ColorsMangerDark.secondaryText,
    surface: ColorsMangerLight.surface,
    onSurface: ColorsMangerLight.onSurface,
  ),
  textTheme: TextTheme(
    labelSmall: lightThin(11),
    labelMedium: lightMedium(12),
    labelLarge: lightThin(14),
    titleMedium: lightMedium(18),
    titleLarge: lightMedium(22),

  ),
);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: ColorsMangerDark.backGroundColor,
  primaryColor: ColorsMangerDark.primaryColor,
);
