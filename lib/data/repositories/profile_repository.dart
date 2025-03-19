// lib/data/repositories/profile_repository.dart

import 'dart:io';
import '../data_providers/api_service.dart';
import '../../core/constants/api_constants.dart';

class ProfileRepository {
  final ApiService apiService;

  ProfileRepository({required this.apiService});

  /// GET /api/users/profiles/
  /// The backend returns a single object, e.g. { "id":2, "first_name":"Ahmed", "email":..., ... }
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
  /// Partial update with or without image (flattened user fields).
  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required int profileId,
    required String firstName,
    required String lastName,
    required String? email,    // Add email (can be null if user is not updating email)
    required String phone,
    required String address,
    required String bio,
    File? image,
  }) async {
    final endpoint = '${ApiConstants.profiles}$profileId/';

    // If there's an image, do multipart
    if (image != null) {
      final fields = {
        'first_name': firstName,
        'last_name': lastName,
        if (email != null) 'email': email, // flatten email if not null
        'phone': phone,
        'address': address,
        'bio': bio,
      };
      return apiService.patchMultipart(endpoint, fields, image: image, token: token);

    } else {
      // Otherwise do JSON patch
      final body = {
        'first_name': firstName,
        'last_name': lastName,
        if (email != null) 'email': email, // flatten email
        'phone': phone,
        'address': address,
        'bio': bio,
      };
      return apiService.patchJson(endpoint, body, token: token);
    }
  }
}
