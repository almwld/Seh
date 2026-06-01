class ApiService {
  static const String baseUrl = 'https://sehatak-api.example.com/api';
  static String? _token;

  static void setToken(String token) {
    _token = token;
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return {
      'success': true,
      'token': 'test_token',
      'user': {'id': '1', 'full_name': 'مستخدم', 'email': email}
    };
  }

  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    return {'success': true, 'token': 'test_token'};
  }

  static Future<Map<String, dynamic>> getProfile() async {
    return {'success': true, 'data': {'id': '1', 'full_name': 'مستخدم'}};
  }

  static Future<List<dynamic>> getDoctors({String? specialty}) async {
    return [{'id': '1', 'full_name': 'د. محمد', 'specialization': 'قلبية', 'rating': 4.8}];
  }
}
