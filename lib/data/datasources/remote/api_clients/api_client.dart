import 'package:dio/dio.dart';
import 'package:sehatak/core/constants/api_endpoints.dart';
import 'package:sehatak/core/constants/app_config.dart';

class ApiClient {
  late Dio _dio;
  static ApiClient? _instance;

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.enableOfflineMode ? ApiEndpoints.baseUrl : ApiEndpoints.baseUrl,
      connectTimeout: const Duration(milliseconds: AppConfig.apiTimeout),
      receiveTimeout: const Duration(milliseconds: AppConfig.apiTimeout),
      sendTimeout: const Duration(milliseconds: AppConfig.apiTimeout),
      headers: {
        'Content-Type': AppConfig.apiContentType,
        'Accept': AppConfig.apiAccept,
      },
    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (o) => print(o),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available
        // final token = await AuthService.getToken();
        // if (token != null) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          // Handle token refresh or logout
        }
        return handler.next(e);
      },
    ));
  }

  factory ApiClient() {
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  Dio get dio => _dio;

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) async {
    return await _dio.delete(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) async {
    return await _dio.patch(path, data: data);
  }
}
