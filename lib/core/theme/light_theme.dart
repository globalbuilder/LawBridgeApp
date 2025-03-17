// lib/core/theme/light_theme.dart
import 'package:flutter/material.dart';

const ColorScheme _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0B3D91),   // Strong blue
  onPrimary: Colors.white,
  secondary: Color(0xFFFFC107), // Amber
  onSecondary: Colors.black,
  error: Color(0xFFB00020),
  onError: Colors.white,
  surface: Colors.white,
  onSurface: Colors.black,
);

final ThemeData lightTheme = ThemeData(
  colorScheme: _lightColorScheme,
  useMaterial3: true,
  scaffoldBackgroundColor: _lightColorScheme.surface,

  appBarTheme: AppBarTheme(
    backgroundColor: _lightColorScheme.primary,
    foregroundColor: _lightColorScheme.onPrimary,
    elevation: 2,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _lightColorScheme.primary,
      foregroundColor: _lightColorScheme.onPrimary,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
  ),
);
