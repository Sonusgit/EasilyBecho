import 'package:dio/dio.dart';
import 'package:easilybecho/core/data/error/app_exception.dart';

class ExceptionMapper {
  ExceptionMapper._();

  static AppException fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NoInternetException();

      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);

      case DioExceptionType.cancel:
        return const UnknownException(message: 'Request was cancelled.');

      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') == true ||
            error.message?.contains('No address associated') == true) {
          return const NoInternetException();
        }
        return UnknownException(message: error.message ?? 'Unknown error');

      default:
        return UnknownException(message: error.message ?? 'Unknown error');
    }
  }

  static AppException _handleResponseError(Response? response) {
    if (response == null) {
      return const UnknownException(message: 'No response from server.');
    }

    final statusCode = response.statusCode;
    final message = _extractMessage(response.data);

    switch (statusCode) {
      case 400:
        return ServerException(
          message: message ?? 'Bad request.',
          statusCode: statusCode,
          code: 'BAD_REQUEST',
          data: response.data,
        );
      case 401:
        return const UnauthorizedException();
      case 403:
        return const ForbiddenException();
      case 404:
        return const NotFoundException();
      case 422:
        return ServerException(
          message: message ?? 'Validation failed.',
          statusCode: statusCode,
          code: 'VALIDATION_ERROR',
          data: response.data,
        );
      case 429:
        return ServerException(
          message: 'Too many requests. Please slow down.',
          statusCode: statusCode,
          code: 'RATE_LIMIT',
        );
      case 500:
      case 502:
      case 503:
        return ServerException(
          message: message ?? 'Server error. Please try again later.',
          statusCode: statusCode,
          code: 'SERVER_ERROR',
        );
      default:
        return ServerException(
          message: message ?? 'Something went wrong.',
          statusCode: statusCode,
        );
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data == null) return null;
    if (data is Map<String, dynamic>) {
      return data['message'] ??
          data['error'] ??
          data['detail'] ??
          data['msg'];
    }
    if (data is String) return data;
    return null;
  }
}