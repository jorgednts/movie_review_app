import 'package:design_system/src/theme/text_theme_util.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  final TextTheme textTheme;

  const CustomTheme(this.textTheme);

  factory CustomTheme.fromContext(BuildContext context) {
    final textTheme = createTextTheme(context: context);
    return CustomTheme(textTheme);
  }

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004e73),
      surfaceTint: Color(0xff006492),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff006796),
      onPrimaryContainer: Color(0xffbde1ff),
      secondary: Color(0xff486175),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcbe6fd),
      onSecondaryContainer: Color(0xff4e677b),
      tertiary: Color(0xff633776),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7d4f90),
      onTertiaryContainer: Color(0xfff5d1ff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff7f9fe),
      onSurface: Color(0xff191c1f),
      onSurfaceVariant: Color(0xff40484f),
      outline: Color(0xff707880),
      outlineVariant: Color(0xffc0c7d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3134),
      inversePrimary: Color(0xff8bceff),
      primaryFixed: Color(0xffcae6ff),
      onPrimaryFixed: Color(0xff001e2f),
      primaryFixedDim: Color(0xff8bceff),
      onPrimaryFixedVariant: Color(0xff004b6f),
      secondaryFixed: Color(0xffcbe6fd),
      onSecondaryFixed: Color(0xff011e2f),
      secondaryFixedDim: Color(0xffb0cae0),
      onSecondaryFixedVariant: Color(0xff30495c),
      tertiaryFixed: Color(0xfff8d8ff),
      onTertiaryFixed: Color(0xff310345),
      tertiaryFixedDim: Color(0xffe9b3fc),
      onTertiaryFixedVariant: Color(0xff603473),
      surfaceDim: Color(0xffd8dade),
      surfaceBright: Color(0xfff7f9fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f4f8),
      surfaceContainer: Color(0xffeceef2),
      surfaceContainerHigh: Color(0xffe6e8ec),
      surfaceContainerHighest: Color(0xffe0e2e7),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003a57),
      surfaceTint: Color(0xff006492),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff006796),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1f394b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff577084),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4e2361),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7d4f90),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7f9fe),
      onSurface: Color(0xff0e1215),
      onSurfaceVariant: Color(0xff2f373e),
      outline: Color(0xff4c535b),
      outlineVariant: Color(0xff666e75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3134),
      inversePrimary: Color(0xff8bceff),
      primaryFixed: Color(0xff1e73a3),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005a84),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff577084),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3f586b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8a5b9d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff704383),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c7cb),
      surfaceBright: Color(0xfff7f9fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f4f8),
      surfaceContainer: Color(0xffe6e8ec),
      surfaceContainerHigh: Color(0xffdbdde1),
      surfaceContainerHighest: Color(0xffcfd2d6),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8bceff),
      surfaceTint: Color(0xff8bceff),
      onPrimary: Color(0xff00344e),
      primaryContainer: Color(0xff006796),
      onPrimaryContainer: Color(0xffbde1ff),
      secondary: Color(0xffb0cae0),
      onSecondary: Color(0xff193345),
      secondaryContainer: Color(0xff30495c),
      onSecondaryContainer: Color(0xff9eb8cf),
      tertiary: Color(0xffe9b3fc),
      onTertiary: Color(0xff481d5b),
      tertiaryContainer: Color(0xff7d4f90),
      onTertiaryContainer: Color(0xfff5d1ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101417),
      onSurface: Color(0xffe0e2e7),
      onSurfaceVariant: Color(0xffc0c7d0),
      outline: Color(0xff8a929a),
      outlineVariant: Color(0xff40484f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e7),
      inversePrimary: Color(0xff006492),
      primaryFixed: Color(0xffcae6ff),
      onPrimaryFixed: Color(0xff001e2f),
      primaryFixedDim: Color(0xff8bceff),
      onPrimaryFixedVariant: Color(0xff004b6f),
      secondaryFixed: Color(0xffcbe6fd),
      onSecondaryFixed: Color(0xff011e2f),
      secondaryFixedDim: Color(0xffb0cae0),
      onSecondaryFixedVariant: Color(0xff30495c),
      tertiaryFixed: Color(0xfff8d8ff),
      onTertiaryFixed: Color(0xff310345),
      tertiaryFixedDim: Color(0xffe9b3fc),
      onTertiaryFixedVariant: Color(0xff603473),
      surfaceDim: Color(0xff101417),
      surfaceBright: Color(0xff36393d),
      surfaceContainerLowest: Color(0xff0b0f12),
      surfaceContainerLow: Color(0xff191c1f),
      surfaceContainer: Color(0xff1d2023),
      surfaceContainerHigh: Color(0xff272a2e),
      surfaceContainerHighest: Color(0xff323539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );
}
