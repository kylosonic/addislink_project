import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primary = Color(0xFF000000); // Utilitarian Black
  static const Color accent = Color(0xFFFFCC00); // Taxi Yellow
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8F9FA); // Slightly off-white
  static const Color inputFill = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);

  // Shadows
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get glassShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static TextTheme _textTheme = GoogleFonts.poppinsTextTheme();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: accent,
        surface: surface,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: textPrimary,
      ),
      
      // Typography
      textTheme: _textTheme.copyWith(
        displayLarge: _textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w600, color: textPrimary),
        displayMedium: _textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w600, color: textPrimary),
        titleLarge: _textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: textPrimary),
        titleMedium: _textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, color: textPrimary),
        bodyLarge: _textTheme.bodyLarge?.copyWith(color: textPrimary),
        bodyMedium: _textTheme.bodyMedium?.copyWith(color: textSecondary),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: surface,
        elevation: 0, // Using manual shadows usually, but clear default elevation
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.zero,
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
      ),
    );
  }
}
