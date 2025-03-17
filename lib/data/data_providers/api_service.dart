// lib/data/data_providers/api_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import '../../core/constants/api_constants.dart';

class ApiService {
  final String baseUrl = ApiConstants.baseUrl;

  Map<String, dynamic> _parseResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else if (decoded is List) {
        return {"list": decoded};
      } else {
        // Unexpected type
        return {"unexpected": decoded};
      }
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    final url = _buildUrl(endpoint, queryParameters);
    final headers = _buildHeaders(token);
    final response = await http.get(url, headers: headers);
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final url = _buildUrl(endpoint, null);
    final headers = _buildHeaders(token);
    final response = await http.post(url, headers: headers, body: jsonEncode(body));
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final url = _buildUrl(endpoint, null);
    final headers = _buildHeaders(token);
    final response = await http.put(url, headers: headers, body: jsonEncode(body));
    return _parseResponse(response);
  }

  Future<void> delete(String endpoint, {String? token}) async {
    final url = _buildUrl(endpoint, null);
    final headers = _buildHeaders(token);
    final response = await http.delete(url, headers: headers);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('DELETE Error: ${response.statusCode}, ${response.body}');
    }
  }

  Future<Map<String, dynamic>> patchJson(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final url = _buildUrl(endpoint, null);
    final headers = _buildHeaders(token);
    final response = await http.patch(url, headers: headers, body: jsonEncode(body));
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> patchMultipart(
    String endpoint,
    Map<String, String> fields, {
    File? image,
    String? token,
  }) async {
    final url = _buildUrl(endpoint, null);
    final request = http.MultipartRequest('PATCH', url);

    request.fields.addAll(fields);
    if (image != null) {
      final fileName = p.basename(image.path);
      request.files.add(await http.MultipartFile.fromPath('image', image.path, filename: fileName));
    }

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else if (decoded is List) {
        return {"list": decoded};
      } else {
        return {"unexpected": decoded};
      }
    } else {
      throw Exception('Multipart PATCH Error: ${response.statusCode}, ${response.body}');
    }
  }

  /// Helper to build the URL
  Uri _buildUrl(String endpoint, Map<String, dynamic>? queryParameters) {
    Uri url = Uri.parse('$baseUrl$endpoint');
    if (queryParameters != null && queryParameters.isNotEmpty) {
      url = url.replace(queryParameters: queryParameters.map((k, v) => MapEntry(k, v.toString())));
    }
    return url;
  }

  /// Helper to build headers
  Map<String, String> _buildHeaders(String? token) {
    final headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}
