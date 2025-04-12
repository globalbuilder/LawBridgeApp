import 'package:flutter/material.dart';

class AppTheme {
  // -----------------------------------------------------------------
  // Color Palette (from reference image)
  // -----------------------------------------------------------------
  static const Color colorDarkPurple = Color(0xFF312C51);
  static const Color colorMediumPurple = Color(0xFF48426D);
  static const Color colorPeach = Color.fromARGB(255, 255, 202, 146);
  static const Color colorPinkish = Color.fromARGB(255, 235, 179, 116);

  // -----------------------------------------------------------------
  // Light Theme Color Palette
  // -----------------------------------------------------------------
  static const Color lightPrimary = colorDarkPurple;    // #312C51
  static const Color lightAccent = colorMediumPurple;   // #48426D
  static const Color lightBackground = colorPeach;      // #F0C38E
  static const Color lightSurface = colorPinkish;       // #F1AA9B
  static const Color lightText = Color(0xFF312C51);     // Dark purple text
  static const Color lightButton = colorMediumPurple;   // #48426D

  // -----------------------------------------------------------------
  // Dark Theme Color Palette
  // -----------------------------------------------------------------
  static const Color darkPrimary = colorPeach;          // #F0C38E
  static const Color darkAccent = colorPinkish;         // #F1AA9B
  static const Color darkBackground = colorDarkPurple;  // #312C51
  static const Color darkSurface = colorMediumPurple;   // #48426D
  static const Color darkText = Colors.white;
  static const Color darkButton = colorPeach;           // #F0C38E

  // -----------------------------------------------------------------
  // Light Theme
  // -----------------------------------------------------------------
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground, // #F0C38E
    primaryColor: lightPrimary,               // #312C51
    appBarTheme: const AppBarTheme(
      backgroundColor: lightPrimary,          // #312C51
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: lightPrimary,             // #312C51
      onPrimary: Colors.white,
      secondary: lightAccent,            // #48426D
      onSecondary: Colors.white,
      surface: lightSurface,             // #F1AA9B
      onSurface: lightText,              // #312C51
      error: Colors.red,
      onError: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightButton,   // #48426D
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: lightPrimary), // #312C51
    inputDecorationTheme: InputDecorationTheme(
      fillColor: lightSurface, // #F1AA9B
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: const TextStyle(color: lightText), // #312C51
      hintStyle: TextStyle(color: lightText.withOpacity(0.6)),
    ),
  );

  // -----------------------------------------------------------------
  // Dark Theme
  // -----------------------------------------------------------------
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground, // #312C51
    primaryColor: darkPrimary,               // #F0C38E
    appBarTheme: AppBarTheme(
      backgroundColor: darkPrimary,          // #F0C38E
      foregroundColor: darkBackground,       // #312C51
      titleTextStyle: TextStyle(
        color: darkBackground, // #312C51
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: darkPrimary,             // #F0C38E
      onPrimary: darkBackground,        // #312C51
      secondary: darkAccent,            // #F1AA9B
      onSecondary: darkBackground,      // #312C51
      background: darkBackground,       // #312C51
      onBackground: darkText,           // #FFFFFF
      surface: darkSurface,             // #48426D
      onSurface: darkText,              // #FFFFFF
      error: Colors.red.shade400,
      onError: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkButton,  // #F0C38E
        foregroundColor: darkBackground, // #312C51
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    iconTheme: IconThemeData(color: darkAccent), // #F1AA9B
    inputDecorationTheme: InputDecorationTheme(
      fillColor: darkSurface, // #48426D
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: const TextStyle(color: Colors.white),
      hintStyle: const TextStyle(color: Colors.white60),
    ),
  );
}
