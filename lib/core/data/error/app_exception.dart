abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class NoInternetException extends AppException {
  const NoInternetException()
      : super('No internet connection. Please check your network.');
}

class ServerUnavailableException extends AppException {
  const ServerUnavailableException()
      : super('Server is temporarily unavailable. Please try again.');
}

class TimeoutException extends AppException {
  const TimeoutException()
      : super('Request timed out. Please try again.');
}

// ✅ FIX: Now accepts server message
// 401 on login  → "Login failed - invalid credentials"  (from server)
// 401 elsewhere → "Invalid credentials." (default)
class UnauthorizedException extends AppException {
  const UnauthorizedException({String message = 'Invalid credentials.'})
      : super(message);
}

class ForbiddenException extends AppException {
  const ForbiddenException({String message = 'You do not have permission.'})
      : super(message);
}

class NotFoundException extends AppException {
  const NotFoundException({String message = 'Resource not found.'})
      : super(message);
}

class BadRequestException extends AppException {
  const BadRequestException({String message = 'Bad request.'})
      : super(message);
}

class TooManyRequestsException extends AppException {
  const TooManyRequestsException()
      : super('Too many requests. Please slow down.');
}

class ServerException extends AppException {
  const ServerException({String message = 'Server error. Please try again.'})
      : super(message);
}

class RequestCancelledException extends AppException {
  const RequestCancelledException()
      : super('Request was cancelled.');
}

class UnknownException extends AppException {
  const UnknownException({String message = 'Something went wrong.'})
      : super(message);
}