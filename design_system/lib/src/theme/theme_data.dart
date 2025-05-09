import 'package:flutter/material.dart';

class AppTheme {
  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: Color(0xFFB20B08),
  );
  static ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: Color(0xFFB20B08),
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
