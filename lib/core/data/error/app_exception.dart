/// Base exception for all app exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  const AppException({
    required this.message,
    this.code,
    this.data,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Thrown when there is no internet connection
class NoInternetException extends AppException {
  const NoInternetException({
    super.message = 'No internet connection. Please check your network.',
    super.code = 'NO_INTERNET',
  });
}

/// Thrown when the server returns an error response
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    required super.message,
    this.statusCode,
    super.code,
    super.data,
  });

  @override
  String toString() => 'ServerException: $message (statusCode: $statusCode)';
}

/// Thrown when request times out
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Request timed out. Please try again.',
    super.code = 'TIMEOUT',
  });
}

/// Thrown when the user is unauthorized (401)
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Unauthorized. Please login again.',
    super.code = 'UNAUTHORIZED',
  });
}

/// Thrown when access is forbidden (403)
class ForbiddenException extends AppException {
  const ForbiddenException({
    super.message = 'Access denied.',
    super.code = 'FORBIDDEN',
  });
}

/// Thrown when resource is not found (404)
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found.',
    super.code = 'NOT_FOUND',
  });
}

/// Thrown when there is a local cache/parsing error
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code = 'CACHE_ERROR',
  });
}

/// Thrown for unexpected errors
class UnknownException extends AppException {
  const UnknownException({
    super.message = 'An unexpected error occurred.',
    super.code = 'UNKNOWN',
    super.data,
  });
}