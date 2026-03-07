import 'package:dio/dio.dart';
import 'package:easilybecho/core/data/configs/api_constants.dart';
import 'package:easilybecho/core/data/services/secure_storage_helper.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorageHelper.getUserToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired - attempt refresh
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry original request with new token
        final token = await SecureStorageHelper.getUserToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $token';
        try {
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          // Refresh failed, force logout
          await _forceLogout();
        }
      } else {
        await _forceLogout();
      }
    }
    handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      final oldToken = await SecureStorageHelper.getUserToken();
      if (oldToken == null) return false;

      final response = await dio.post(
        ApiConstants.refreshToken,
        data: {'token': oldToken},
      );

      if (response.statusCode == 200) {
        final newToken = response.data['access_token'];
        await SecureStorageHelper.setUserToken(newToken);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> _forceLogout() async {
    await SecureStorageHelper.clearAllUserData();
    // Navigate to login - use your router/navigator here
    // e.g., Get.offAllNamed('/login') or router.go('/login')
  }
}