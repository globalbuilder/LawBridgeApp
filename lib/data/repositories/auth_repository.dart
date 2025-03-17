// lib/data/repositories/auth_repository.dart

import 'dart:io';
import '../data_providers/api_service.dart';
import '../../core/constants/api_constants.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository({required this.apiService});

  /// Login with /login/ (SimpleJWT)
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final response = await apiService.post(
      ApiConstants.login,
      {
        'username': username,
        'password': password,
      },
    );
    return response; // contains { 'access': ..., 'refresh': ... }
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    File? image,  // optional
  }) async {
    // Convert to string fields
    final fields = {
      'username': username,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
    };

    // If there's an image, we pass it to postMultipart
    final response = await apiService.patchMultipart(
      ApiConstants.register,
      fields,
      image: image,
    );
    return response; 
  }
}
