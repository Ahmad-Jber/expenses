import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getThemeData(
    ColorScheme colorScheme,
    Color scaffoldBackgroundColor,
  ) {
    return ThemeData().copyWith(
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: colorScheme.onPrimaryContainer,
        foregroundColor: colorScheme.primaryContainer,
        shadowColor: colorScheme.secondary,
        surfaceTintColor: colorScheme.secondary,
      ),
      cardTheme: const CardThemeData().copyWith(
        color: colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.all(2),
        elevation: 1,
      ),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
    );
  }
}
