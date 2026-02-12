import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easilybecho/core/extensions/app_log_Print_extention.dart';
import 'package:easilybecho/core/helpers/toast/toast_helper.dart';

class ErrorHandler {
  ErrorHandler._();

  /// Handle error and return user-friendly message
  static String handle(dynamic error, {bool showToast = false}) {
    String errorMessage = '';

    if (error is DioException) {
      errorMessage = _handleDioError(error);
    } else if (error is SocketException) {
      errorMessage = 'No internet connection';
    } else if (error is FormatException) {
      errorMessage = 'Invalid data format';
    } else {
      errorMessage = error.toString().replaceAll('Exception:', '').trim();
    }

    // Use appLogger instead of log
    'Error: $errorMessage'.logError(error, StackTrace.current, tag: 'ErrorHandler');

    if (showToast) {
      ToastHelper.showError('Error', errorMessage);
    }

    return errorMessage;
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please try again';

      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again';

      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond';

      case DioExceptionType.badResponse:
        return _extractMessage(error.response?.data);

      case DioExceptionType.cancel:
        return 'Request was cancelled';

      case DioExceptionType.connectionError:
        return 'No internet connection';

      case DioExceptionType.badCertificate:
        return 'Security error occurred';

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return 'No internet connection';
        }
        return 'Something went wrong';

      default:
        return 'Something went wrong';
    }
  }

  /// Extract message from server response (dynamic data)
  static String _extractMessage(dynamic data) {
    if (data == null) return 'Something went wrong';

    try {
      if (data is Map) {
        // Check for message field (priority order)
        if (data['message'] != null && data['message'].toString().isNotEmpty) {
          return data['message'].toString();
        }
        if (data['error'] != null && data['error'].toString().isNotEmpty) {
          return data['error'].toString();
        }
        if (data['msg'] != null && data['msg'].toString().isNotEmpty) {
          return data['msg'].toString();
        }
      }

      if (data is String) {
        return data;
      }

      return 'Something went wrong';
    } catch (e) {
      return 'Something went wrong';
    }
  }

  /// Show error toast with auto message extraction
  static void showErrorToast(dynamic error, {String? customMessage}) {
    final errorMessage = customMessage ?? handle(error, showToast: false);
    ToastHelper.showError('Error', errorMessage);
  }

  /// Show success toast
  static void showSuccessToast(String message) {
    'Success: $message'.logInfo(tag: 'ErrorHandler');
    ToastHelper.showSuccess('Success', message);
  }

  /// Handle API response and show appropriate toast
  /// Returns true if success, false if failed
  static bool handleResponse(dynamic response, {bool showToast = true}) {
    try {
      if (response is Map) {
        final status = response['status']?.toString().toLowerCase();
        final message = _extractMessage(response);

        if (status == 'success' || status == 'ok') {
          // Auto log success
          'API Success: $message'.logInfo(tag: 'API_Response');
          
          if (showToast) {
            ToastHelper.showSuccess('Success', message);
          }
          return true;
        } else {
          // Auto log error
          'API Error: $message (Status: $status)'.logWarning(tag: 'API_Response');
          
          if (showToast) {
            ToastHelper.showError('Error', message);
          }
          return false;
        }
      }
      return true;
    } catch (e) {
      'Response handling error: ${e.toString()}'.logError(
        e,
        StackTrace.current,
        tag: 'API_Response',
      );
      
      if (showToast) {
        ToastHelper.showError('Error', 'Something went wrong');
      }
      return false;
    }
  }

  /// Extract and return message from response without showing toast
  static String getMessageFromResponse(dynamic data) {
    return _extractMessage(data);
  }
}