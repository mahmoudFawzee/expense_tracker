import 'package:expense_tracker/presentation/theme/color_manger.dart';
import 'package:flutter/material.dart';

const _fontFamily = 'WinkySans';

TextStyle _textStyle({
  required double size,
  required FontWeight weight,
  required Color color,
}) =>
    TextStyle(
      fontFamily: _fontFamily,
      fontWeight: weight,
      color: color,
    );

TextStyle _lightThemeTextColor({
  required double size,
  required FontWeight weight,
}) =>
    _textStyle(
      size: size,
      weight: weight,
      color: ColorsMangerLight.onSurface,
    );
TextStyle _darkThemeTextColor({
  required double size,
  required FontWeight weight,
}) =>
    _textStyle(
      size: size,
      weight: weight,
      color: ColorsMangerLight.surface,
    );
TextStyle lightBold(double size) => _lightThemeTextColor(
      size: size,
      weight: FontWeight.bold,
    );

TextStyle lightMedium(double size) => _lightThemeTextColor(
      size: size,
      weight: FontWeight.w400,
    );

TextStyle lightThin(double size) => _lightThemeTextColor(
      size: size,
      weight: FontWeight.w200,
    );

TextStyle darkBold(double size) => _darkThemeTextColor(
      size: size,
      weight: FontWeight.bold,
    );

TextStyle darkMedium(double size) => _darkThemeTextColor(
      size: size,
      weight: FontWeight.w400,
    );

TextStyle darkThin(double size) => _darkThemeTextColor(
      size: size,
      weight: FontWeight.w200,
    );
