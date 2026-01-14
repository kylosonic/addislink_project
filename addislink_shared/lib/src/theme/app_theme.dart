import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors - High Contrast
  static const Color primary = Color(0xFF000000); // Utilitarian Black
  static const Color accent = Color(0xFFFFCC00); // Taxi/Cargo Yellow (High vis)
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);

  static TextTheme _textTheme = GoogleFonts.robotoTextTheme();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: accent,
        surface: surface,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
      ),
      scaffoldBackgroundColor: background,
      textTheme: _textTheme.copyWith(
        displayLarge: _textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        titleLarge: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        bodyLarge: _textTheme.bodyLarge?.copyWith(color: Colors.black87),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
