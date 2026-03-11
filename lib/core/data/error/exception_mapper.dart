import 'package:dio/dio.dart';
import 'package:easilybecho/core/data/error/app_exception.dart';

class ExceptionMapper {
  ExceptionMapper._();

  static AppException fromDioException(DioException e) {
    switch (e.type) {

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        final msg   = e.message ?? '';
        final inner = e.error?.toString() ?? '';
        if (msg.contains('Failed host lookup') ||
            inner.contains('Failed host lookup') ||
            inner.contains('No address associated') ||
            inner.contains('errno = 7')) {
          return const ServerUnavailableException();
        }
        return const NoInternetException();

      case DioExceptionType.badResponse:
        // ✅ Always extract server message first
        return _fromStatusCode(e.response?.statusCode, e.response?.data);

      case DioExceptionType.cancel:
        return const RequestCancelledException();

      default:
        return UnknownException(message: e.message ?? 'Something went wrong.');
    }
  }

  static AppException _fromStatusCode(int? statusCode, dynamic data) {
    // ✅ Server ka message pehle lo — jaise "Login failed - invalid credentials"
    final serverMessage = _extractMessage(data);

    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: serverMessage ?? 'Bad request.',
        );
      case 401:
        // ✅ FIX: Server message use karo (e.g. "Login failed - invalid credentials")
        // Pehle: hardcoded "Session expired" — wrong for login failure!
        return UnauthorizedException(
          message: serverMessage ?? 'Invalid credentials.',
        );
      case 403:
        return ForbiddenException(
          message: serverMessage ?? 'You do not have permission.',
        );
      case 404:
        return NotFoundException(
          message: serverMessage ?? 'Resource not found.',
        );
      case 408:
        return const TimeoutException();
      case 422:
        return BadRequestException(
          message: serverMessage ?? 'Validation failed.',
        );
      case 429:
        return const TooManyRequestsException();
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException(
          message: serverMessage ?? 'Server error. Please try again.',
        );
      default:
        return UnknownException(
          message: serverMessage ?? 'Unexpected error ($statusCode).',
        );
    }
  }

  // ✅ Extracts "message" from server response
  // Handles: { "status": "Failed", "message": "Login failed...", "statusCode": 401 }
  static String? _extractMessage(dynamic data) {
    if (data == null) return null;
    if (data is Map) {
      return data['message']?.toString() ??
             data['error']?.toString()   ??
             data['msg']?.toString();
    }
    if (data is String && data.isNotEmpty) return data;
    return null;
  }
}