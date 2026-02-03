// lib/services/api_service.dart
import 'dart:convert';
import 'dart:developer' show log;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easilybecho/core/helpers/toast/toast_helper.dart';
import 'package:easilybecho/services/auth_interceptor.dart';
import 'package:easilybecho/services/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  
  late Dio _dio;
  bool _isInterceptorAdded = false;

  ApiService._internal() {
    _dio = Dio();
    _setupDio();
  }

  // Setup Dio with base configuration
  void _setupDio() {
    _dio.options.baseUrl = 'https://your-api-base-url.com/api/'; // Set your base URL
    _dio.options.connectTimeout = Duration(seconds: 30);
    _dio.options.receiveTimeout = Duration(seconds: 30);
    _dio.options.sendTimeout = Duration(seconds: 30);
  }

  // Initialize interceptor (call this after login or app start)
  void initializeInterceptor(String refreshTokenEndpoint) {
    if (!_isInterceptorAdded) {
      _dio.interceptors.add(
        AuthInterceptor(_dio, refreshTokenEndpoint: refreshTokenEndpoint),
      );
      _isInterceptorAdded = true;
      log("✅ Auth Interceptor initialized");
    }
  }

  // Remove interceptor (call this on logout)
  void removeInterceptor() {
    if (_isInterceptorAdded) {
      _dio.interceptors.clear();
      _isInterceptorAdded = false;
      log("🗑️ Auth Interceptor removed");
    }
  }

  Future<Response?> requestGetForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
    BuildContext? context,
  }) async {
    log("authToken = $authToken");
    log("GET url = $url");
    log("GET parameter = ${dictParameter.toString()}");
    
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }

    try {
      final response = await _dio.get(
        url,
        queryParameters: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: authToken ? await getHeader(authToken) : {},
          validateStatus: (_) => true,
        ),
      );
      log("GET Response = ${response.data}");
      return response;
    } catch (e, s) {
      log("GET Exception = $e");
      log("GET Stacktrace = $s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<Response?> requestPostForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
    BuildContext? context,
  }) async {
    log("authToken = $authToken");
    log("POST url = $url");
    log("POST parameter = ${dictParameter.toString()}");
    
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }

    try {
      final response = await _dio.post(
        url,
        data: dictParameter,
        options: Options(
          headers: authToken ? await getHeader(authToken) : {},
          validateStatus: (_) => true,
        ),
      );
      log("POST Response = ${response.data}");
      return response;
    } catch (e, s) {
      log("POST Exception = $e");
      log("POST Stacktrace = $s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<Response?> requestPostWithFormData({
    required String url,
    required FormData formData,
    required bool authToken,
    Function(int, int)? onSendProgress,
    BuildContext? context,
  }) async {
    log("authToken = $authToken");
    log("POST url = $url (FormData)");
    
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }

    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: authToken ? await getHeaderForFormData(authToken) : {},
          sendTimeout: Duration(seconds: 60),
          receiveTimeout: Duration(seconds: 60),
          validateStatus: (_) => true,
        ),
        onSendProgress: onSendProgress,
      );
      log("POST FormData Response = ${response.data}");
      return response;
    } catch (e, s) {
      log("POST FormData Exception = $e");
      log("POST FormData Stacktrace = $s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<FormData> createFormData({
    required Map<String, dynamic> data,
    File? imageFile,
    String imageFieldName = 'profileImage',
  }) async {
    Map<String, dynamic> formDataMap = {};

    data.forEach((key, value) {
      if (value != null) {
        if (value is Map || value is List) {
          formDataMap[key] = jsonEncode(value);
        } else {
          formDataMap[key] = value.toString();
        }
      }
    });

    if (imageFile != null) {
      String fileName = imageFile.path.split('/').last;
      formDataMap[imageFieldName] = await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      );
    }

    return FormData.fromMap(formDataMap);
  }

  Future<Response?> requestPutForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
    BuildContext? context,
  }) async {
    log("authToken = $authToken");
    log("PUT url = $url");
    log("PUT parameter = ${dictParameter.toString()}");
    
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }

    try {
      final response = await _dio.put(
        url,
        data: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: authToken ? await getHeader(authToken) : {},
          validateStatus: (_) => true,
        ),
      );
      log("PUT Response = ${response.data}");
      return response;
    } catch (e, s) {
      log("PUT Exception = $e");
      log("PUT Stacktrace = $s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<Response?> requestPatchForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
    BuildContext? context,
  }) async {
    log("authToken = $authToken");
    log("PATCH url = $url");
    log("PATCH parameter = ${dictParameter.toString()}");
    
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }

    try {
      final response = await _dio.patch(
        url,
        data: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: authToken ? await getHeader(authToken) : {},
          validateStatus: (_) => true,
        ),
      );
      log("PATCH Response = ${response.data}");
      return response;
    } catch (e, s) {
      log("PATCH Exception = $e");
      log("PATCH Stacktrace = $s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<Response?> requestDeleteForApi({
    required String url,
    Map<String, dynamic>? dictParameter,
    required bool authToken,
    BuildContext? context,
  }) async {
    log("authToken = $authToken");
    log("DELETE url = $url");
    log("DELETE parameter = ${dictParameter.toString()}");
    
    bool hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (!hasInternet) {
      log("❌ No Internet Connection");
      if (context != null) {
        ToastHelper.warning(message: "No Internet Connection", context: context);
      }
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: "No Internet Connection",
        data: {"error": "No Internet"},
      );
    }

    try {
      final response = await _dio.delete(
        url,
        data: dictParameter,
        options: Options(
          contentType: 'application/json',
          headers: authToken ? await getHeader(authToken) : {},
          validateStatus: (_) => true,
        ),
      );
      log("DELETE Response = ${response.data}");
      return response;
    } catch (e, s) {
      log("DELETE Exception = $e");
      log("DELETE Stacktrace = $s");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: 0,
        statusMessage: e.toString(),
        data: {"error": e},
      );
    }
  }

  Future<Map<String, String>> getHeader(bool authToken) async {
    if (authToken) {
      String? jwtToken = await TokenManager.getAccessToken();
      log("header accessToken = $jwtToken");

      return {
        "Content-type": "application/json",
        "Authorization": "Bearer $jwtToken",
      };
    } else {
      return {"Content-type": "application/json"};
    }
  }

  Future<Map<String, String>> getHeaderForFormData(bool authToken) async {
    if (authToken) {
      String? jwtToken = await TokenManager.getAccessToken();
      log("header accessToken = $jwtToken");

      return {
        "Content-type": "multipart/form-data",
        "Authorization": "Bearer $jwtToken",
      };
    } else {
      return {"Content-type": "multipart/form-data"};
    }
  }
}