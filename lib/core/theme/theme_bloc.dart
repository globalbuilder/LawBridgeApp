// lib/core/theme/theme_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

/// We define an enum or class for our events.
abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

enum AppThemeMode { light, dark }

/// Our state holds the current theme data and mode.
class ThemeState {
  final ThemeData themeData;
  final AppThemeMode themeMode;

  const ThemeState({
    required this.themeData,
    required this.themeMode,
  });

}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          ThemeState(
            themeData: lightTheme,
            themeMode: AppThemeMode.light,
          ),
        ) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    if (state.themeMode == AppThemeMode.light) {
      emit(
        ThemeState(
          themeData: darkTheme,
          themeMode: AppThemeMode.dark,
        ),
      );
    } else {
      emit(
        ThemeState(
          themeData: lightTheme,
          themeMode: AppThemeMode.light,
        ),
      );
    }
  }
}
