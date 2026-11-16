import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const Color ink = Color(0xFF1D2733);
  static const Color mute = Color(0xFF6B7886);
  static const Color coral = Color(0xFFF4877B);
  static const Color paleTeal = Color(0xFFE9F7F4);
  static const Color teal = Color(0xFF1F9A85);
  static const Color line = Color(0xFFE3ECEA);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: paleTeal,
    colorScheme: ColorScheme.fromSeed(
      seedColor: coral,
      primary: coral,
      secondary: const Color(0xFF5FD0BF),
      surface: Colors.white,
      onSurface: ink,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: ink, fontFamily: 'Inter'),
      bodyMedium: TextStyle(color: ink, fontFamily: 'Inter'),
      bodySmall: TextStyle(color: mute, fontFamily: 'Inter'),
      titleLarge: TextStyle(
        color: ink,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: line),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: line),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: teal),
      ),
    ),
  );
}
