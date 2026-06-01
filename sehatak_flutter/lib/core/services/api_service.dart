import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://sehatak-backend-v2.onrender.com/api';
  static String? _token;

  static void setToken(String token) {
    _token = token;
  }

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_token != null) 'Authorization': 'Bearer $_token',
  };

  // ========== AUTH ==========
  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
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
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: _headers,
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);
    if (data['token'] != null) _token = data['token'];
    return data;
  }

  // ========== AI ==========
  static Future<Map<String, dynamic>> triage({
    required String symptoms,
    String? bodyPart,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ai/triage'),
      headers: _headers,
      body: jsonEncode({'symptoms': symptoms, 'body_part': bodyPart}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> chatbot(String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ai/chatbot'),
      headers: _headers,
      body: jsonEncode({'message': message}),
    );
    return jsonDecode(response.body);
  }

  // ========== DOCTORS ==========
  static Future<List<dynamic>> getDoctors({String? specialty}) async {
    final url = specialty != null
        ? '$baseUrl/doctors?specialty=$specialty'
        : '$baseUrl/doctors';
    final response = await http.get(Uri.parse(url), headers: _headers);
    return jsonDecode(response.body);
  }

  // ========== CONSULTATIONS ==========
  static Future<Map<String, dynamic>> bookConsultation({
    required String doctorId,
    required String type,
    required String symptoms,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/consultations'),
      headers: _headers,
      body: jsonEncode({
        'doctor_id': doctorId,
        'type': type,
        'symptoms': symptoms,
      }),
    );
    return jsonDecode(response.body);
  }

  // ========== ORDERS ==========
  static Future<Map<String, dynamic>> placeOrder({
    required String orderType,
    required Map<String, dynamic> details,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: _headers,
      body: jsonEncode({
        'order_type': orderType,
        ...details,
      }),
    );
    return jsonDecode(response.body);
  }

  // ========== PROFILE ==========
  static Future<Map<String, dynamic>> getProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/profile'),
      headers: _headers,
    );
    return jsonDecode(response.body);
  }

  // ========== NOTIFICATIONS ==========
  static Future<List<dynamic>> getNotifications() async {
    final response = await http.get(
      Uri.parse('$baseUrl/notifications'),
      headers: _headers,
    );
    return jsonDecode(response.body);
  }
}
