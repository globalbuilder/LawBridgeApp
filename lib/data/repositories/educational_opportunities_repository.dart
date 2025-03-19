// lib/data/repositories/educational_opportunities_repository.dart

import '../data_providers/api_service.dart';
import '../../core/constants/api_constants.dart';

class EducationalOpportunitiesRepository {
  final ApiService apiService;

  EducationalOpportunitiesRepository({required this.apiService});

  /// Fetch all educational opportunities
  Future<List<Map<String, dynamic>>> fetchAllOpportunities() async {
    // Suppose your API endpoint is /api/educationalopportunities/
    final result = await apiService.get(ApiConstants.educationalOpportunities);

    // If your backend returns { "list": [...] }
    if (result.containsKey('list')) {
      final listData = result['list'];
      if (listData is List) {
        return List<Map<String, dynamic>>.from(listData);
      } else {
        throw Exception('Unexpected list data format');
      }
    }

    // If direct array
    if (result is List) {
      return List<Map<String, dynamic>>.from(result as Iterable);
    }
    throw Exception('Unexpected response. Array of opportunities expected.');
  }

  /// Fetch a single opportunity detail
  Future<Map<String, dynamic>> fetchOpportunityDetail(int id) async {
    final endpoint = '${ApiConstants.educationalOpportunities}$id/';
    final result = await apiService.get(endpoint);

    // Expect a single object with "id"
    if (result.containsKey('id')) {
      return result;
    }
    throw Exception('Unexpected opportunity detail format');
  }
}
