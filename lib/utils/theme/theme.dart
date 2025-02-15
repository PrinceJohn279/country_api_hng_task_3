import 'package:flutter/material.dart';

import 'custom_theme.dart/text_theme.dart';

class AppTheme {
  AppTheme._();

// LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.white,
    textTheme: MyTextTheme.lightTextTheme,
  );

// DARK THEME
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    scaffoldBackgroundColor: const Color.fromARGB(255, 24, 20, 20),
    textTheme: MyTextTheme.darkTextTheme,
  );
}
