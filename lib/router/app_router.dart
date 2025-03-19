// lib/router/app_router.dart

import 'package:flutter/material.dart';

// Import your screens
import '../presentation/screens/favorites/favorites_screen.dart';
import '../presentation/screens/home/main_home_screen.dart';
import '../presentation/screens/login/login_screen.dart';
import '../presentation/screens/login/register_screen.dart';
import '../presentation/screens/profile/profile_screen.dart';
import '../presentation/screens/profile/edit_profile_screen.dart';

// Legal Resources
import '../presentation/screens/legal_resources/resource_list_screen.dart';
import '../presentation/screens/legal_resources/resource_detail_screen.dart';

// Educational Opportunities
import '../presentation/screens/educational_opportunities/education_opportunity_list_screen.dart';
import '../presentation/screens/educational_opportunities/education_opportunity_detail_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // HOME:
      case '/':
        return MaterialPageRoute(
          builder: (_) => const MainHomeScreen(),
        );

      // AUTH:
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case '/register':
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );

      // PROFILE:
      case '/profile':
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case '/profile/edit':
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        );

      // LEGAL RESOURCES:
      case '/legalresource/list':
        return MaterialPageRoute(
          builder: (_) => const ResourceListScreen(),
        );
      case '/legalresource/detail':
        return MaterialPageRoute(
          builder: (_) => const ResourceDetailScreen(),
        );

      // EDUCATIONAL OPPORTUNITIES:
      case '/educationalopportunities/list':
        return MaterialPageRoute(
          builder: (_) => const EducationOpportunityListScreen(),
        );
      case '/educationalopportunities/detail':
        return MaterialPageRoute(
          builder: (_) => const EducationOpportunityDetailScreen(),
        );

      case '/favorites':
        return MaterialPageRoute(
          builder: (_) => const FavoritesScreen(),
        );

      // 404 - Not Found:
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page Not Found')),
          ),
        );
    }
  }
}
