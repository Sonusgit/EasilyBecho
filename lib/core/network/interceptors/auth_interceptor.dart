import 'package:dio/dio.dart';
import 'package:easilybecho/core/extensions/app_log_print_extention.dart';
import 'package:easilybecho/core/helpers/toast/toast_helper.dart';
import 'package:easilybecho/core/navigation/routes/app_router.dart';
import 'package:easilybecho/core/network/services/secure_storage_helper.dart';
import 'package:flutter/foundation.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final String refreshTokenEndpoint;
  final VoidCallback? onTokenExpired;

  AuthInterceptor(
    this._dio, {
    required this.refreshTokenEndpoint,
    this.onTokenExpired,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      "🔒 Unauthorized (401) - Token expired".logWarning(tag: 'AuthInterceptor');

      // Try to refresh token
      final refreshed = await _attemptTokenRefresh();

      if (refreshed) {
        // Retry the original request
        try {
          final opts = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          );
          
          final token = await SecureStorageHelper.getUserToken();
          opts.headers?['Authorization'] = 'Bearer $token';

          final cloneReq = await _dio.request(
            err.requestOptions.path,
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );

          return handler.resolve(cloneReq);
        } catch (e) {
          // If retry fails, logout
          await _handleLogout();
        }
      } else {
        // Token refresh failed, logout
        await _handleLogout();
      }
    }

    handler.next(err);
  }

  Future<bool> _attemptTokenRefresh() async {
    try {
      final refreshToken = await SecureStorageHelper.getUserToken();
      if (refreshToken == null) return false;

      "🔄 Attempting token refresh".logInfo(tag: 'AuthInterceptor');

      final response = await _dio.post(
        refreshTokenEndpoint,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final newToken = response.data['accessToken'] ?? response.data['token'];
        if (newToken != null) {
          await SecureStorageHelper.setUserToken(newToken);
          "✅ Token refreshed successfully".logInfo(tag: 'AuthInterceptor');
          return true;
        }
      }
    } catch (e, stackTrace) {
      "❌ Token refresh failed".logError(e, stackTrace, tag: 'AuthInterceptor');
    }

    return false;
  }

  Future<void> _handleLogout() async {
    "🚪 Logging out user".logWarning(tag: 'AuthInterceptor');

    // Clear user data
    await SecureStorageHelper.clearAllUserData();

    // Show toast
    ToastHelper.error(
      title: 'Session Expired',
      message: 'Please login again',
    );

    // Call callback if provided
    onTokenExpired?.call();

    // Navigate to login
    AppRouter.navigateToLogin();
  }
}