import 'package:dio/dio.dart';
import '../config/env_config.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({String? baseUrl, int? timeout}) {
    final effectiveBaseUrl = baseUrl ?? EnvConfig.apiBaseUrl;
    final effectiveTimeout = timeout ?? EnvConfig.apiTimeout;

    _dio = Dio(
      BaseOptions(
        baseUrl: effectiveBaseUrl,
        connectTimeout: Duration(milliseconds: effectiveTimeout),
        receiveTimeout: Duration(milliseconds: effectiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (EnvConfig.isLoggingEnabled) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
        ),
      );
    }
  }

  Dio get dio => _dio;

  String get configInfo =>
      'API: ${_dio.options.baseUrl} | Timeout: ${_dio.options.connectTimeout?.inSeconds}s | Env: ${EnvConfig.environment}';
}
