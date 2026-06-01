import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // للاختبار - قبول أي تسجيل دخول
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return {
      'success': true,
      'token': 'test_token_123',
      'user': {
        'id': '1',
        'full_name': 'مستخدم',
        'email': email,
        'phone': email,
      }
    };
  }

  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    return {
      'success': true,
      'token': 'test_token_123',
    };
  }

  static Future<Map<String, dynamic>> getProfile() async {
    return {
      'success': true,
      'data': {
        'id': '1',
        'full_name': 'مستخدم',
        'email': 'test@sehatak.com',
      }
    };
  }
}
