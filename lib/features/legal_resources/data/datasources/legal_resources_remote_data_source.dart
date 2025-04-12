import 'package:flutter/foundation.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/utils/api_client.dart';
import '../models/legal_resource_model.dart';
import '../models/favorite_resource_model.dart';

abstract class ILegalResourcesRemoteDataSource {
  Future<List<LegalResourceModel>> getResources({String? search});
  Future<LegalResourceModel> getResourceDetail(int id);

  Future<List<FavoriteResourceModel>> getFavoriteResources();
  Future<void> addFavorite(int resourceId);
  Future<void> removeFavorite(int resourceId);
}

class LegalResourcesRemoteDataSourceImpl
    implements ILegalResourcesRemoteDataSource {
  final ApiClient apiClient;

  LegalResourcesRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<LegalResourceModel>> getResources({String? search}) async {
    try {
      final params =
          (search != null && search.isNotEmpty) ? {'search': search} : null;

      final response = await apiClient.get(
        ApiEndpoints.legalResources,
        queryParameters: params,
      );

      final List<dynamic> data = response as List<dynamic>;
      return data
          .map((json) => LegalResourceModel.fromJson(json))
          .toList(growable: false);
    } catch (e) {
      debugPrint('getResources error: $e');
      rethrow;
    }
  }

  @override
  Future<LegalResourceModel> getResourceDetail(int id) async {
    try {
      final url =
          ApiEndpoints.legalResourceDetail.replaceAll('<id>', id.toString());
      final response = await apiClient.get(url);
      return LegalResourceModel.fromJson(response);
    } catch (e) {
      debugPrint('getResourceDetail error: $e');
      rethrow;
    }
  }

  @override
  Future<List<FavoriteResourceModel>> getFavoriteResources() async {
    try {
      final response = await apiClient.get(ApiEndpoints.legalResourcesFavorites);
      final List<dynamic> data = response as List<dynamic>;
      return data
          .map((json) => FavoriteResourceModel.fromJson(json))
          .toList(growable: false);
    } catch (e) {
      debugPrint('getFavoriteResources error: $e');
      rethrow;
    }
  }

  @override
  Future<void> addFavorite(int resourceId) async {
    try {
      await apiClient.post(
        ApiEndpoints.legalResourceAddFavorite,
        body: {'resource_id': resourceId},
      );
    } catch (e) {
      debugPrint('addFavorite error: $e');
      rethrow;
    }
  }

  @override
  Future<void> removeFavorite(int resourceId) async {
    try {
      final url =
          '${ApiEndpoints.legalResourceRemoveFavorite}$resourceId/';
      await apiClient.delete(url);
    } catch (e) {
      debugPrint('removeFavorite error: $e');
      rethrow;
    }
  }
}
