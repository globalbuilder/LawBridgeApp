// lib/data/repositories/profile_repository.dart
import 'dart:io';
import '../data_providers/api_service.dart';
import '../../core/constants/api_constants.dart';

class ProfileRepository {
  final ApiService apiService;

  ProfileRepository({required this.apiService});

  /// GET /api/users/profiles/
  /// The backend returns a single object, e.g. { "id":2, "first_name":"Ahmed", ... }
  Future<Map<String, dynamic>> fetchProfile({required String token}) async {
    final result = await apiService.get(
      ApiConstants.profiles,
      token: token,
    );
    // Check if it's a single map
    if (result.containsKey('id')) {
      // The returned object has "id" plus other fields. Good.
      return result;
    }
    throw Exception('Unexpected response. "id" field missing');
  }

  /// PATCH /api/users/profiles/<profile_id>/
  /// partial update with or without image
  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required int profileId,
    required String firstName,
    required String lastName,
    required String phone,
    required String address,
    required String bio,
    File? image,
  }) async {
    final endpoint = '${ApiConstants.profiles}$profileId/';
    if (image != null) {
      final fields = {
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'address': address,
        'bio': bio,
      };
      return await apiService.patchMultipart(endpoint, fields, image: image, token: token);
    } else {
      final body = {
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'address': address,
        'bio': bio,
      };
      return await apiService.patchJson(endpoint, body, token: token);
    }
  }
}
