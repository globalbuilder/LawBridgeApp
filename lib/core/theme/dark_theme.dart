// lib/core/theme/dark_theme.dart
import 'package:flutter/material.dart';

const ColorScheme _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFBB86FC), 
  onPrimary: Colors.black,
  secondary: Color(0xFF03DAC6),
  onSecondary: Colors.black,
  error: Color(0xFFCF6679),
  onError: Colors.black,
  surface: Color(0xFF1E1E1E),
  onSurface: Colors.white,
);

final ThemeData darkTheme = ThemeData(
  colorScheme: _darkColorScheme,
  useMaterial3: true,
  scaffoldBackgroundColor: _darkColorScheme.surface,

  appBarTheme: AppBarTheme(
    backgroundColor: _darkColorScheme.primary,
    foregroundColor: _darkColorScheme.onPrimary,
    elevation: 2,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _darkColorScheme.primary,
      foregroundColor: _darkColorScheme.onPrimary,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
  ),
);
