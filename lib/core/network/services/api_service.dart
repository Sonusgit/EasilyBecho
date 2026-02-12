import 'package:dio/dio.dart';
import 'package:easilybecho/core/extensions/app_log_print_extention.dart';
import 'package:easilybecho/core/helpers/toast/toast_helper.dart';
import 'package:easilybecho/core/network/configs/api_constants.dart';
import 'package:easilybecho/core/network/dio_client.dart';
import 'package:easilybecho/core/network/error/error_handler.dart';
import 'package:easilybecho/core/network/network_info.dart';
import 'package:easilybecho/core/network/services/secure_storage_helper.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final DioClient _dioClient;
  final NetworkInfo _networkInfo;

  ApiService({
    required DioClient dioClient,
    required NetworkInfo networkInfo,
  })  : _dioClient = dioClient,
        _networkInfo = networkInfo;

  // Initialize auth interceptor
  void initAuth({VoidCallback? onTokenExpired}) {
    _dioClient.addAuthInterceptor(
      refreshEndpoint: ApiConstants.refreshToken,
      onTokenExpired: onTokenExpired,
    );
  }

  // Remove auth interceptor
  void removeAuth() {
    _dioClient.removeAuthInterceptor();
  }

  // Check internet and show toast if no connection
  Future<bool> _checkInternet() async {
    final hasInternet = await _networkInfo.isConnected;
    if (!hasInternet) {
      "❌ No Internet Connection".logWarning(tag: 'Network');
      ToastHelper.warning(title: "No Internet Connection");
    }
    return hasInternet;
  }

  // Get auth headers
  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await SecureStorageHelper.getUserToken();
    if (token == null || token.isEmpty) {
      "⚠️ No auth token found".logWarning(tag: 'ApiService');
      return {};
    }
    return {'Authorization': 'Bearer $token'};
  }

  // Handle response
  void _handleResponse(Response response, bool showToast) {
    if (!showToast) return;

    final data = response.data;
    if (data is! Map) return;

    final status = data['status']?.toString().toLowerCase();
    final message = data['message'] ?? '';

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (status == 'success' && message.isNotEmpty) {
        ToastHelper.success(title: 'Success', message: message);
      }
    } else {
      final errorMsg = ErrorHandler.getMessageFromResponse(data);
      ToastHelper.error(title: 'Error', message: errorMsg);
    }
  }

  // GET Request
  Future<Response?> get({
    required String endpoint,
    Map<String, dynamic>? params,
    bool requiresAuth = false,
    bool showToast = false,
  }) async {
    if (!await _checkInternet()) return null;

    try {
      final headers = requiresAuth ? await _getAuthHeaders() : null;

      final response = await _dioClient.dio.get(
        endpoint,
        queryParameters: params,
        options: Options(headers: headers),
      );

      _handleResponse(response, showToast);
      return response;
    } catch (e, stackTrace) {
      "GET Failed: $endpoint".logError(e, stackTrace, tag: 'ApiService');
      if (showToast) ErrorHandler.showErrorToast(e);
      return null;
    }
  }

  // POST Request
  Future<Response?> post({
    required String endpoint,
    dynamic data,
    bool requiresAuth = false,
    bool showToast = false,
  }) async {
    if (!await _checkInternet()) return null;

    try {
      final headers = requiresAuth ? await _getAuthHeaders() : null;

      final response = await _dioClient.dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );

      _handleResponse(response, showToast);
      return response;
    } catch (e, stackTrace) {
      "POST Failed: $endpoint".logError(e, stackTrace, tag: 'ApiService');
      if (showToast) ErrorHandler.showErrorToast(e);
      return null;
    }
  }

  // POST FormData
  Future<Response?> postFormData({
    required String endpoint,
    required FormData formData,
    bool requiresAuth = false,
    bool showToast = false,
    ProgressCallback? onProgress,
  }) async {
    if (!await _checkInternet()) return null;

    try {
      final headers = requiresAuth ? await _getAuthHeaders() : <String, dynamic>{};
      headers['Content-Type'] = 'multipart/form-data';

      final response = await _dioClient.dio.post(
        endpoint,
        data: formData,
        options: Options(headers: headers),
        onSendProgress: onProgress,
      );

      _handleResponse(response, showToast);
      return response;
    } catch (e, stackTrace) {
      "POST FormData Failed: $endpoint".logError(e, stackTrace, tag: 'ApiService');
      if (showToast) ErrorHandler.showErrorToast(e);
      return null;
    }
  }

  // PUT Request
  Future<Response?> put({
    required String endpoint,
    dynamic data,
    bool requiresAuth = false,
    bool showToast = false,
  }) async {
    if (!await _checkInternet()) return null;

    try {
      final headers = requiresAuth ? await _getAuthHeaders() : null;

      final response = await _dioClient.dio.put(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );

      _handleResponse(response, showToast);
      return response;
    } catch (e, stackTrace) {
      "PUT Failed: $endpoint".logError(e, stackTrace, tag: 'ApiService');
      if (showToast) ErrorHandler.showErrorToast(e);
      return null;
    }
  }

  // PATCH Request
  Future<Response?> patch({
    required String endpoint,
    dynamic data,
    bool requiresAuth = false,
    bool showToast = false,
  }) async {
    if (!await _checkInternet()) return null;

    try {
      final headers = requiresAuth ? await _getAuthHeaders() : null;

      final response = await _dioClient.dio.patch(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );

      _handleResponse(response, showToast);
      return response;
    } catch (e, stackTrace) {
      "PATCH Failed: $endpoint".logError(e, stackTrace, tag: 'ApiService');
      if (showToast) ErrorHandler.showErrorToast(e);
      return null;
    }
  }

  // DELETE Request
  Future<Response?> delete({
    required String endpoint,
    dynamic data,
    bool requiresAuth = false,
    bool showToast = false,
  }) async {
    if (!await _checkInternet()) return null;

    try {
      final headers = requiresAuth ? await _getAuthHeaders() : null;

      final response = await _dioClient.dio.delete(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );

      _handleResponse(response, showToast);
      return response;
    } catch (e, stackTrace) {
      "DELETE Failed: $endpoint".logError(e, stackTrace, tag: 'ApiService');
      if (showToast) ErrorHandler.showErrorToast(e);
      return null;
    }
  }

  // Download File
  Future<Response?> download({
    required String endpoint,
    required String savePath,
    bool requiresAuth = false,
    ProgressCallback? onProgress,
  }) async {
    if (!await _checkInternet()) return null;

    try {
      final headers = requiresAuth ? await _getAuthHeaders() : null;

      final response = await _dioClient.dio.download(
        endpoint,
        savePath,
        options: Options(headers: headers),
        onReceiveProgress: onProgress,
      );

      "File downloaded: $savePath".logInfo(tag: 'ApiService');
      return response;
    } catch (e, stackTrace) {
      "Download Failed: $endpoint".logError(e, stackTrace, tag: 'ApiService');
      ErrorHandler.showErrorToast(e);
      return null;
    }
  }
}