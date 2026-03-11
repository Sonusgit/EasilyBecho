import 'package:dio/dio.dart';
import 'package:easilybecho/core/data/configs/api_constants.dart';
import 'package:easilybecho/core/data/network/connectivity_interceptor.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/logging_interceptor.dart';

/// FIX: Removed RetryInterceptor — BaseApiService already retries.
/// Having RetryInterceptor + BaseApiService retry = calls multiplied.
///
/// Retry flow now:
///   ConnectivityInterceptor → block if NO network (flight mode)
///   BaseApiService._request() → retry up to 4x on DNS/connection errors
class DioClient {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
        sendTimeout: const Duration(milliseconds: ApiConstants.sendTimeout),
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
        },
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.addAll([
      LoggingInterceptor(),
      AuthInterceptor(dio),
      ConnectivityInterceptor(),
      // ❌ RetryInterceptor REMOVED — BaseApiService handles all retries
    ]);

    return dio;
  }

  static void reset() => _dio = null;
}