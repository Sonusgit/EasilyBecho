import 'package:dio/dio.dart';
import 'package:easilybecho/core/extensions/app_log_print_extention.dart';
import 'package:easilybecho/core/network/configs/api_constants.dart';
import 'package:easilybecho/core/network/interceptors/auth_interceptor.dart';
import 'package:easilybecho/core/network/interceptors/logging_interceptor.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  late Dio _dio;
  bool _isAuthInterceptorAdded = false;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectionTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    // Add logging interceptor
    _dio.interceptors.add(LoggingInterceptor());

    "✅ DioClient initialized".logInfo(tag: 'DioClient');
  }

  Dio get dio => _dio;

  void addAuthInterceptor({
    required String refreshEndpoint,
    VoidCallback? onTokenExpired,
  }) {
    if (!_isAuthInterceptorAdded) {
      _dio.interceptors.add(
        AuthInterceptor(
          _dio,
          refreshTokenEndpoint: refreshEndpoint,
          onTokenExpired: onTokenExpired,
        ),
      );
      _isAuthInterceptorAdded = true;
      "✅ Auth Interceptor added".logInfo(tag: 'DioClient');
    }
  }

  void removeAuthInterceptor() {
    if (_isAuthInterceptorAdded) {
      _dio.interceptors.removeWhere((i) => i is AuthInterceptor);
      _isAuthInterceptorAdded = false;
      "🗑️ Auth Interceptor removed".logInfo(tag: 'DioClient');
    }
  }

  void close() {
    _dio.close(force: true);
    "🔒 DioClient closed".logInfo(tag: 'DioClient');
  }
}
