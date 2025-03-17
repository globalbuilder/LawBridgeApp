// lib/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:law_bridge/presentation/screens/legal_resources/resource_detail_screen.dart';
import '../presentation/screens/login/login_screen.dart';
import '../presentation/screens/login/register_screen.dart';
import '../presentation/screens/home/main_home_screen.dart';
import '../presentation/screens/settings/settings_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../presentation/screens/profile/edit_profile_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainHomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/profile/edit':
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
        case '/legalresource/detail':
        return MaterialPageRoute(builder: (_) => const ResourceDetailScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}
