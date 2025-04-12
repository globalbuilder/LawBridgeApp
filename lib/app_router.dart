// lib/app_router.dart

import 'package:flutter/material.dart';
import 'features/app/presentation/pages/favorites_screen.dart';
import 'features/app/presentation/pages/search_screen.dart';
import 'features/app/presentation/pages/splash_screen.dart';
import 'features/app/presentation/pages/home_screen.dart';
import 'features/accounts/presentation/pages/login_screen.dart';
import 'features/accounts/presentation/pages/registration_screen.dart';
import 'features/accounts/presentation/pages/profile_screen.dart';
import 'features/accounts/presentation/pages/profile_edit_screen.dart';
import 'features/accounts/presentation/pages/password_change_screen.dart';
import 'features/notifications/presentation/pages/notification_detail_screen.dart';
import 'features/settings/presentation/pages/settings_screen.dart';
import 'features/educational_opportunities/presentation/pages/educational_opportunities_screen.dart';
import 'features/educational_opportunities/presentation/pages/educational_opportunity_detail_screen.dart';
import 'features/educational_opportunities/presentation/pages/search_educational_opportunity_screen.dart';
import 'features/educational_opportunities/presentation/pages/educational_opportunities_favorites_screen.dart';
import 'features/legal_resources/presentation/pages/legal_resources_screen.dart';
import 'features/legal_resources/presentation/pages/legal_resource_detail_screen.dart';
import 'features/legal_resources/presentation/pages/search_legal_resource_screen.dart';
import 'features/legal_resources/presentation/pages/legal_resources_favorites_screen.dart';
import 'features/notifications/presentation/pages/notifications_screen.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';
  static const String changePassword = '/change-password';
  static const String settings = '/settings';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String opportunitiesList = '/educational-opportunities';
  static const String opportunityDetail = '/opportunity-detail';
  static const String searchEducationalOpportunity =
      '/search-educational-opportunity';
  static const String educationalOpportunityFavorites =
      '/educational-opportunities/favorites';
  static const String resourcesList = '/legal-resources';
  static const String resourceDetail = '/legal-resource-detail';
  static const String searchLegalResource = '/search-legal-resource';
  static const String legalResourceFavorites = '/legal-resources/favorites';
  static const String notifications = '/notifications';
  static const String notificationDetail = '/notification-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case profileEdit:
        return MaterialPageRoute(builder: (_) => const ProfileEditScreen());
      case changePassword:
        return MaterialPageRoute(builder: (_) => const PasswordChangeScreen());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case AppRouter.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case opportunitiesList:
        return MaterialPageRoute(
            builder: (_) => const EducationalOpportunitiesScreen());
      case opportunityDetail:
        final id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => EducationalOpportunityDetailScreen(id: id));
      case searchEducationalOpportunity:
        return MaterialPageRoute(
            builder: (_) => const SearchEducationalOpportunityScreen());
      case educationalOpportunityFavorites:
        return MaterialPageRoute(
            builder: (_) => const EducationalOpportunitiesFavoritesScreen());
      case resourcesList:
        return MaterialPageRoute(builder: (_) => const LegalResourcesScreen());
      case resourceDetail:
        final id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => LegalResourceDetailScreen(id: id));
      case searchLegalResource:
        return MaterialPageRoute(
            builder: (_) => const SearchLegalResourceScreen());
      case legalResourceFavorites:
        return MaterialPageRoute(
            builder: (_) => const LegalResourcesFavoritesScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case notificationDetail:
        final id = settings.arguments as int; 
        return MaterialPageRoute(
          builder: (_) => NotificationDetailScreen(id: id), 
        );

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
