// lib/data/repositories/favorites_repository.dart

import '../data_providers/api_service.dart';
import '../../core/constants/api_constants.dart';

class FavoritesRepository {
  final ApiService apiService;

  FavoritesRepository({required this.apiService});

  /// Create a favorite resource
  Future<Map<String, dynamic>> addResourceFavorite({
    required String token,
    required int resourceId,
  }) async {
    final endpoint = '${ApiConstants.favoritesResources}';
    final body = {'resource': resourceId};
    // We assume an endpoint: POST /api/favorites/resources/
    final result = await apiService.post(endpoint, body, token: token);
    return result; 
  }

  /// Remove a favorite resource by its favorite ID
  Future<void> removeResourceFavorite({
    required String token,
    required int favoriteId,
  }) async {
    final endpoint = '${ApiConstants.favoritesResources}$favoriteId/';
    // We assume DELETE /api/favorites/resources/<favoriteId>/
    await apiService.delete(endpoint, token: token);
  }

  /// Get list of favorited resources
  Future<List<Map<String, dynamic>>> getFavoriteResources({required String token}) async {
    final endpoint = '${ApiConstants.favoritesResources}';
    final result = await apiService.get(endpoint, token: token);
    if (result is List) {
      return List<Map<String, dynamic>>.from(result as Iterable);
    }
    throw Exception('Unexpected favorites resources format');
  }

  /// Create a favorite opportunity
  Future<Map<String, dynamic>> addOpportunityFavorite({
    required String token,
    required int opportunityId,
  }) async {
    final endpoint = '${ApiConstants.favoritesOpportunities}';
    final body = {'opportunity': opportunityId};
    // POST /api/favorites/opportunities/
    final result = await apiService.post(endpoint, body, token: token);
    return result;
  }

  /// Remove a favorite opportunity
  Future<void> removeOpportunityFavorite({
    required String token,
    required int favoriteId,
  }) async {
    final endpoint = '${ApiConstants.favoritesOpportunities}$favoriteId/';
    await apiService.delete(endpoint, token: token);
  }

  /// Get list of favorited opportunities
  Future<List<Map<String, dynamic>>> getFavoriteOpportunities({required String token}) async {
    final endpoint = '${ApiConstants.favoritesOpportunities}';
    final result = await apiService.get(endpoint, token: token);
    if (result is List) {
      return List<Map<String, dynamic>>.from(result as Iterable);
    }
    throw Exception('Unexpected favorites opportunities format');
  }
}
