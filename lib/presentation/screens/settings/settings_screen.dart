// lib/presentation/screens/settings/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/theme_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings Screen (BLoC)'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Dispatch an event to toggle the theme
            context.read<ThemeBloc>().add(ToggleThemeEvent());
          },
          child: const Text('Toggle Theme'),
        ),
      ),
    );
  }
}
