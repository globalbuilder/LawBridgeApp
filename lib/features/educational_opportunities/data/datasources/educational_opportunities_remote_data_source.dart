import 'package:flutter/foundation.dart';
import '../../../../core/utils/api_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../models/opportunity_model.dart';
import '../models/favorite_opportunity_model.dart';

abstract class IEducationalOpportunitiesRemoteDataSource {
  Future<List<OpportunityModel>> getOpportunities({String? search});
  Future<OpportunityModel> getOpportunityDetail(int id);
  Future<List<FavoriteOpportunityModel>> getFavoriteOpportunities();
  Future<void> addFavorite(int opportunityId);
  Future<void> removeFavorite(int opportunityId);
}

class EducationalOpportunitiesRemoteDataSourceImpl
    implements IEducationalOpportunitiesRemoteDataSource {
  final ApiClient apiClient;

  EducationalOpportunitiesRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<OpportunityModel>> getOpportunities({String? search}) async {
    try {
      final params = search != null && search.isNotEmpty
          ? {'search': search}
          : null;

      final response = await apiClient.get(
        ApiEndpoints.educationalOpportunities,
        queryParameters: params,
      );

      final List<dynamic> dataList = response as List<dynamic>;

      return dataList
          .map((jsonItem) => OpportunityModel.fromJson(jsonItem))
          .toList();
    } catch (e) {
      debugPrint("Error in getOpportunities: $e");
      rethrow;
    }
  }

  @override
  Future<OpportunityModel> getOpportunityDetail(int id) async {
    try {
      final detailUrl = ApiEndpoints.educationalOpportunityDetail.replaceAll("<id>", "$id");
      final response = await apiClient.get(detailUrl);
      return OpportunityModel.fromJson(response);
    } catch (e) {
      debugPrint("Error in getOpportunityDetail: $e");
      rethrow;
    }
  }

  @override
  Future<List<FavoriteOpportunityModel>> getFavoriteOpportunities() async {
    try {
      final response = await apiClient.get(ApiEndpoints.educationalOpportunitiesFavorites);
      final List<dynamic> dataList = response as List<dynamic>;
      return dataList
          .map((jsonItem) => FavoriteOpportunityModel.fromJson(jsonItem))
          .toList();
    } catch (e) {
      debugPrint("Error in getFavoriteOpportunities: $e");
      rethrow;
    }
  }

  @override
  Future<void> addFavorite(int opportunityId) async {
    try {
      await apiClient.post(
        ApiEndpoints.educationalOpportunityAddFavorite,
        body: {'opportunity_id': opportunityId},
      );
    } catch (e) {
      debugPrint("Error in addFavorite: $e");
      rethrow;
    }
  }

  @override
  Future<void> removeFavorite(int opportunityId) async {
    try {
      final removeUrl =
          "${ApiEndpoints.educationalOpportunityRemoveFavorite}$opportunityId/";
      await apiClient.delete(removeUrl);
    } catch (e) {
      debugPrint("Error in removeFavorite: $e");
      rethrow;
    }
  }
}
