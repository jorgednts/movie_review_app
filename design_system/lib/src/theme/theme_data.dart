import 'package:flutter/material.dart';

class AppTheme {
  static const seedColor = Color(0xFF854349);
  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
  );
  static ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  );
  static ThemeData light = ThemeData(
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
    useMaterial3: true,
  );
  static ThemeData dark = ThemeData(
    colorScheme: darkColorScheme,
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}
