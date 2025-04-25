import 'package:flutter/material.dart';

/// Tema global do aplicativo
class AppTheme {
  /// Cores principais do app
  static const primaryColor = Colors.green;
  static const secondaryColor = Colors.greenAccent;
  static const backgroundColor = Colors.black;
  static const textColor = Colors.white;

  /// Tema claro do app
  static ThemeData get theme => ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          secondary: secondaryColor,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: textColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor.withAlpha(128)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          labelStyle: TextStyle(color: primaryColor.withAlpha(200)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: textColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      );
}
