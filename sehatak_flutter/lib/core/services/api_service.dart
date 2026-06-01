import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://sehatak-api.onrender.com/api';
  static String? _token;

  static void setToken(String token) {
    _token = token;
  }

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_token != null) 'Authorization': 'Bearer $_token',
  };

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: _headers,
        body: jsonEncode({'email': email, 'password': password}),
      );
      final data = jsonDecode(response.body);
      if (data['token'] != null) _token = data['token'];
      return data;
    } catch (e) {
      // Fallback - تسجيل دخول وهمي
      return {
        'success': true,
        'token': 'offline_token',
        'user': {'id': '1', 'full_name': 'مستخدم', 'email': email}
      };
    }
  }

  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: _headers,
        body: jsonEncode({
          'full_name': fullName,
          'email': email,
          'phone': phone,
          'password': password,
        }),
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': true, 'token': 'offline_token'};
    }
  }

  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/profile'),
        headers: _headers,
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': true, 'data': {'id': '1', 'full_name': 'مستخدم'}};
    }
  }

  static Future<List<dynamic>> getDoctors({String? specialty}) async {
    try {
      final url = specialty != null
          ? '$baseUrl/doctors?specialty=$specialty'
          : '$baseUrl/doctors';
      final response = await http.get(Uri.parse(url), headers: _headers);
      return jsonDecode(response.body);
    } catch (e) {
      return [
        {'id': '1', 'full_name': 'د. محمد', 'specialization': 'قلبية', 'rating': 4.8},
      ];
    }
  }
}
