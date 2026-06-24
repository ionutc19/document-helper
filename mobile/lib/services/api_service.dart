import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/explain_result.dart';
import '../models/create_result.dart';
import 'user_identity.dart';

class ApiService {
  final String baseUrl;
  final http.Client _client;

  ApiService({String? baseUrl, http.Client? client})
      : baseUrl = baseUrl ?? AppConfig.baseUrl,
        _client = client ?? http.Client();

  Map<String, String> get _headers {
    final identity = UserIdentity();
    return {
      'Content-Type': 'application/json',
      'X-User-Id': identity.userId,
      'X-Device-Id': identity.deviceId,
    };
  }

  Future<Map<String, dynamic>> _post(String path, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 429) {
      final data = jsonDecode(response.body);
      final detail = data['detail'];
      final reason = detail is Map ? (detail['reason'] ?? 'limit_reached') : 'limit_reached';
      throw UsageLimitException(reason);
    }
    if (response.statusCode != 200) {
      throw ApiException('Request failed: ${response.statusCode}', response.statusCode);
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _get(String path) async {
    final response = await _client.get(
      Uri.parse('$baseUrl$path'),
      headers: _headers,
    );
    if (response.statusCode != 200) {
      throw ApiException('Request failed: ${response.statusCode}', response.statusCode);
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<ExplainResult> explainDocument({
    required String documentText,
    String language = 'en',
  }) async {
    final data = await _post('/api/explain/analyze', {
      'document_text': documentText,
      'language': language,
    });
    return ExplainResult.fromJson(data);
  }

  Future<CreateResult> createDocument({
    String documentText = '',
    required String outputType,
    required String instructions,
    String language = 'en',
  }) async {
    final data = await _post('/api/create/generate', {
      'document_text': documentText,
      'output_type': outputType,
      'instructions': instructions,
      'language': language,
    });
    return CreateResult.fromJson(data);
  }

  Future<Map<String, dynamic>> getEntitlements() async {
    return await _get('/api/entitlements/me');
  }

  Future<bool> submitFeedback({
    required String category,
    required String title,
    required String description,
    String email = '',
  }) async {
    final data = await _post('/api/feedback', {
      'category': category,
      'title': title,
      'description': description,
      'email': email,
    });
    return data['success'] as bool;
  }

  Future<Map<String, dynamic>> verifyPurchase({
    required String productId,
    required String purchaseToken,
  }) async {
    return await _post('/api/entitlements/verify-purchase', {
      'product_id': productId,
      'purchase_token': purchaseToken,
    });
  }

  Future<bool> checkHealth() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/api/health'),
        headers: _headers,
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  void dispose() {
    _client.close();
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  const ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class UsageLimitException implements Exception {
  final String reason;
  const UsageLimitException(this.reason);

  @override
  String toString() => 'UsageLimitException: $reason';
}
