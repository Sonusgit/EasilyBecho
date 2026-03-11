import 'package:dio/dio.dart';
import 'package:easilybecho/core/data/network/connectivity_manager.dart';

/// FIX: DNS errors (Failed host lookup) must NOT be blocked here.
/// Let them pass to BaseApiService which retries with delay.
/// 
/// This interceptor only blocks when ConnectivityResult.none 
/// (i.e. WiFi/Mobile data fully OFF).
class ConnectivityInterceptor extends Interceptor {
  final ConnectivityManager _connectivityManager = ConnectivityManager();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Only block if device has NO network interface at all (flight mode etc.)
    if (!_connectivityManager.isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          message: 'No internet connection',
        ),
      );
    }

    // ✅ Even if DNS might fail — let it through
    // BaseApiService._request() will retry up to 4x with 2s delay
    handler.next(options);
  }

  // ❌ NO onError override — BaseApiService handles all retries
}