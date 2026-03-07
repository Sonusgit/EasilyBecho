import 'package:dio/dio.dart';
import 'package:easilybecho/core/data/configs/api_constants.dart';
import 'package:easilybecho/core/data/interceptors/retry_Interceptor.dart';
import 'package:easilybecho/core/data/network/connectivity_Interceptor.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/logging_interceptor.dart';

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
        connectTimeout: const Duration(
          milliseconds: ApiConstants.connectTimeout,
        ),
        receiveTimeout: const Duration(
          milliseconds: ApiConstants.receiveTimeout,
        ),
        sendTimeout: const Duration(milliseconds: ApiConstants.sendTimeout),
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
        },
        responseType: ResponseType.json,
      ),
    );

    // Add interceptors in order
    dio.interceptors.addAll([
      LoggingInterceptor(),
      AuthInterceptor(dio),
      ConnectivityInterceptor(),
      RetryInterceptor(dio: dio),
    ]);

    return dio;
  }

  // Reset client (useful for testing or after logout)
  static void reset() {
    _dio = null;
  }
}
