import 'package:flutter/material.dart';

class AppTheme {
  static const Color calmBlue = Color(0xFF4A90E2);
  static const Color calmGreen = Color(0xFF5AC8A8);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: calmBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5FAFF),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: calmGreen,
          brightness: Brightness.dark,
        ),
      );
}
