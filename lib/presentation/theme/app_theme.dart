import 'package:expense_tracker/presentation/theme/color_manger.dart';
import 'package:expense_tracker/presentation/theme/text_theme.dart';
import 'package:flutter/material.dart';

ThemeData getTheme(bool isDark) {
  if (isDark) return _darkTheme;
  return _lightTheme;
}

final ThemeData _lightTheme = ThemeData(
  scaffoldBackgroundColor: ColorsMangerLight.surface,
  appBarTheme: const AppBarTheme(
    color: ColorsMangerLight.surface,
  ),
  iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
    iconColor: WidgetStatePropertyAll(ColorsMangerDark.surface),
  )),
  elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Color(0xffF2F2F2)),
    elevation: WidgetStatePropertyAll(5)
  )),
  primaryIconTheme: const IconThemeData(
    color: ColorsMangerDark.surface,
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
    secondaryContainer: Color(0xffF2F2F2),
    inversePrimary: ColorsMangerLight.successColor,
  ),
  iconTheme: const IconThemeData(
    color: ColorsMangerLight.surface,
  ),
  textTheme: TextTheme(
    labelSmall: lightThin(11),
    labelMedium: lightMedium(12),
    labelLarge: lightThin(14),
    titleSmall: lightMedium(20),
    titleMedium: lightBold(18),
    titleLarge: lightMedium(22),
    bodySmall: lightMedium(18),
    bodyMedium: lightMedium(20),
    bodyLarge: lightMedium(22),
    headlineMedium: lightMedium(24),
    headlineSmall: lightThin(18),
  ),
);

final ThemeData _darkTheme = ThemeData(
  scaffoldBackgroundColor: ColorsMangerDark.surface,
  primaryColor: ColorsMangerDark.primaryColor,
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(ColorsMangerLight.surface),
    ),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xffF2F2F2)),
          elevation: WidgetStatePropertyAll(5))),
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
    secondaryContainer: Color(0xffF2F2F2),
    inversePrimary: ColorsMangerLight.successColor,
  ),
  iconTheme: const IconThemeData(
    color: ColorsMangerLight.surface,
  ),
  textTheme: TextTheme(
    labelSmall: darkThin(11),
    labelMedium: darkMedium(12),
    labelLarge: darkThin(14),
    titleSmall: darkMedium(20),
    titleMedium: darkBold(18),
    titleLarge: darkMedium(22),
    bodySmall: darkMedium(18),
    bodyMedium: darkMedium(20),
    bodyLarge: darkMedium(22),
    headlineMedium: darkMedium(24),
    headlineSmall: darkThin(18),
  ),
);
