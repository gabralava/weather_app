import 'package:flutter/material.dart';
import 'package:weather_app/theme/text_theme.dart';

class ThemeDataStyle {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(206, 229, 255, 1),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: Color.fromRGBO(206, 229, 255, 1),
      primary: Color.fromRGBO(252, 252, 255, 1),
      secondary: Color.fromRGBO(232, 242, 255, 1),
    ),
    textTheme: TextThemeStyle.light,
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(0, 74, 118, 1),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: Color.fromRGBO(0, 74, 118, 1),
      primary: Color.fromRGBO(0, 29, 51, 1),
      secondary: Color.fromRGBO(0, 51, 83, 1),
    ),
    textTheme: TextThemeStyle.dark,
  );
}
