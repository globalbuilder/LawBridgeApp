import 'package:flutter/material.dart';
import 'app_theme.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeData get currentTheme => _isDark ? AppTheme.darkTheme : AppTheme.lightTheme;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void setTheme(bool darkMode) {
    _isDark = darkMode;
    notifyListeners();
  }
}
