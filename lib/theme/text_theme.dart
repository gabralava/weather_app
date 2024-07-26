import 'package:flutter/material.dart';

class TextThemeStyle {
  static TextTheme light = const TextTheme(
    headlineLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.w600, color: Color.fromRGBO(0, 29, 51, 1)),
    titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(0, 29, 51, 1)),
    labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color.fromRGBO(24, 28, 32, 1)),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromRGBO(81, 96, 111, 1)),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromRGBO(81, 96, 111, 1)),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(24, 28, 32, 1)),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(76, 82, 91, 1)),
    bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(76, 82, 91, 1),
    ),
  );

  static TextTheme dark = const TextTheme();
}
