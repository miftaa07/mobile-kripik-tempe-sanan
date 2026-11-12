import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF96491F);
  static const Color background = Color(0xFFFCF9F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color softBrown = Color(0xFFF7E5D2);
  static const Color textDark = Color(0xFF2D241F);
  static const Color textGrey = Color(0xFF817872);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
      ),
      fontFamily: 'Arial',
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
      ),
    );
  }
}