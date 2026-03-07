import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easilybecho/core/data/network/connectivity_manager.dart';

class ConnectivityInterceptor extends Interceptor {
  final ConnectivityManager _connectivityManager = ConnectivityManager();
  final int maxRetries;
  final Duration retryDelay;

  ConnectivityInterceptor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 2),
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Check connection before making request
    if (!_connectivityManager.isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          message: 'No internet connection',
        ),
      );
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final retryCount = err.requestOptions.extra['retryCount'] ?? 0;

      if (retryCount < maxRetries) {
        // Wait for connection to be restored
        await _waitForConnection();
        await Future.delayed(retryDelay);

        // Retry the request
        err.requestOptions.extra['retryCount'] = retryCount + 1;

        try {
          final dio = Dio();
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return super.onError(err, handler);
        }
      }
    }
    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode ?? 0) >= 500;
  }

  Future<void> _waitForConnection() async {
    if (_connectivityManager.isConnected) return;

    final completer = Completer<void>();
    late StreamSubscription subscription;

    subscription = _connectivityManager.connectionStream.listen((isConnected) {
      if (isConnected) {
        subscription.cancel();
        completer.complete();
      }
    });

    // Timeout after 30 seconds
    return completer.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        subscription.cancel();
      },
    );
  }
}
