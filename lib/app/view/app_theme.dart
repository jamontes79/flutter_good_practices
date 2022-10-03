import 'package:flutter/material.dart';

class AppTheme {
  static const appBarColorLight = Color(0xFF134B9F);
  static const accentColorLight = Color(0xFF13B9FF);
  static const accentColorDark = Color(0xFFA51716);
  static const primaryColorLight = Colors.red;
  static const primaryColorDark = Colors.red;
  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColorLight,
      appBarTheme: const AppBarTheme(
        color: primaryColorLight,
      ),
      colorScheme: const ColorScheme.light(
        primary: primaryColorLight,
        secondary: Color(0xFF134B9F),
        tertiary: Color.fromARGB(255, 109, 184, 246),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColorLight,
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.red,
      ),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: accentColorDark,
        tertiary: primaryColorDark,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        textColor: Colors.black,
      ),
    );
  }
}
