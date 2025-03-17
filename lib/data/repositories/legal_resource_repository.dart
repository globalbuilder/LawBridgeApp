// lib/data/repositories/legal_resource_repository.dart
import '../data_providers/api_service.dart';
import '../../core/constants/api_constants.dart';

class LegalResourceRepository {
  final ApiService apiService;
  LegalResourceRepository({required this.apiService});

  /// Fetch all legal resources. We assume no token needed for read, 
  /// or if needed, add a token param.
  Future<List<Map<String, dynamic>>> fetchAllResources() async {
    final result = await apiService.get(ApiConstants.legalResources);
    // If your `api_service` returns {"list": [...]} for an array, handle that.
    if (result.containsKey('list')) {
      final listData = result['list'];
      if (listData is List) {
        return List<Map<String, dynamic>>.from(listData);
      } else {
        throw Exception('Unexpected list data format');
      }
    }
    // If it’s already a list, we do cast:
    if (result is List) {
      return List<Map<String, dynamic>>.from(result as Iterable);
    }
    throw Exception('Unexpected response. Array of resources expected.');
  }

  /// Fetch single resource detail by ID
  Future<Map<String, dynamic>> fetchResourceDetail(int id) async {
    final endpoint = '${ApiConstants.legalResources}$id/';
    final result = await apiService.get(endpoint);
    // Should be a single map
    if (result.containsKey('id')) {
      return result;
    }
    throw Exception('Unexpected resource detail format');
  }
}
