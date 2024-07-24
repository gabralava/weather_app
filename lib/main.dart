import 'package:flutter/material.dart';
import 'package:weather_app/presentation/home_screen.dart';
import 'package:weather_app/theme/color_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeDataStyle.light,
      darkTheme: ThemeDataStyle.dark,
      home: const HomeScreen(),
    );
  }
}
