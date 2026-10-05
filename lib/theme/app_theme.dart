import 'package:flutter/material.dart';

/// Central theme definition for the Admin app.
/// All colours are defined here — never hardcode colours elsewhere.
class AppTheme {
  AppTheme._(); // prevent instantiation

  // ── Brand palette ──────────────────────────────────────────────────────────
  static const Color _primary = Color(0xFF3949AB); // deep indigo
  static const Color _primaryContainer = Color(0xFFE8EAF6);
  static const Color _onPrimary = Colors.white;
  static const Color _secondary = Color(0xFF5C6BC0);
  static const Color _error = Color(0xFFB00020);
  static const Color _background = Color(0xFFF5F6FA);
  static const Color _surface = Colors.white;
  static const Color _onSurface = Color(0xFF1C1B1F);
  static const Color _outline = Color(0xFFBDBDBD);

  // ── Light theme ────────────────────────────────────────────────────────────
  static ThemeData get light {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: _primary,
      onPrimary: _onPrimary,
      primaryContainer: _primaryContainer,
      onPrimaryContainer: _primary,
      secondary: _secondary,
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFE8EAF6),
      onSecondaryContainer: _secondary,
      error: _error,
      onError: Colors.white,
      surface: _surface,
      onSurface: _onSurface,
      outline: _outline,
      outlineVariant: const Color(0xFFE0E0E0),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _background,

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: _primary,
        foregroundColor: _onPrimary,
        elevation: 0,
        centerTitle: true,
      ),

      // InputDecoration – rounded fields (radius 12)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _error, width: 2),
        ),
        errorStyle: const TextStyle(color: _error),
      ),

      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: _onPrimary,
          minimumSize: const Size.fromHeight(52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      // TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primary,
          textStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      // Typography
      textTheme: const TextTheme(
        displaySmall: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: _onSurface),
        headlineMedium: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: _onSurface),
        titleMedium: TextStyle(fontSize: 16, color: Color(0xFF5C5C5C)),
        bodyMedium: TextStyle(fontSize: 14, color: _onSurface),
        bodySmall: TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
      ),
    );
  }
}
