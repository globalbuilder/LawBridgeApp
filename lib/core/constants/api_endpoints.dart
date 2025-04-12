class ApiEndpoints {
  static const String baseUrl = "https://lawbridge.pythonanywhere.com/api";

  static const String register = "$baseUrl/accounts/register/";
  static const String login = "$baseUrl/accounts/login/";
  static const String logout = "$baseUrl/accounts/logout/";
  static const String changePassword = "$baseUrl/accounts/change-password/";
  static const String userInfo = "$baseUrl/accounts/me/";

  static const String educationalOpportunities =
      "$baseUrl/educationalopportunities/";
  static const String educationalOpportunityDetail =
      "$baseUrl/educationalopportunities/<id>/";
  static const String educationalOpportunitiesFavorites =
      "$baseUrl/educationalopportunities/favorites/";
  static const String educationalOpportunityAddFavorite =
      "$baseUrl/educationalopportunities/favorites/add/";
  static const String educationalOpportunityRemoveFavorite =
      "$baseUrl/educationalopportunities/favorites/remove/";

  static const String legalResources = "$baseUrl/legalresources/";
  static const String legalResourceDetail = "$baseUrl/legalresources/<id>/";
  static const String legalResourcesFavorites =
      "$baseUrl/legalresources/favorites/";
  static const String legalResourceAddFavorite =
      "$baseUrl/legalresources/favorites/add/";
  static const String legalResourceRemoveFavorite =
      "$baseUrl/legalresources/favorites/remove/";
  static const String notifications = "$baseUrl/notifications/";
  static const String notificationDetail = "$baseUrl/notifications/<id>/";

}
