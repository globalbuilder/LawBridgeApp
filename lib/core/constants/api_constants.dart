// lib/core/constants/api_constants.dart

class ApiConstants {
  // Your base URL
  static const String baseUrl = 'https://lawbridge.pythonanywhere.com';

  // Auth endpoints (SimpleJWT + RegisterView)
  static const String login = '/api/users/login/';
  static const String loginRefresh = '/api/users/login/refresh/';
  static const String loginVerify = '/api/users/login/verify/';
  static const String register = '/api/users/register/';

  // Potential future endpoints
  static const String profiles = '/api/users/profiles/';
  static const String legalResources = '/api/legalresources/';
  static const String educationalOpportunities = '/api/educationalopportunities/';
  static const String favoriteResources = '/api/favorites/resources/';
  static const String favoriteOpportunities = '/api/favorites/opportunities/';
  static const String notifications = '/api/notifications/';
}
