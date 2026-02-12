class ApiConstants {
  ApiConstants._();

  // Base URLs
  static const String baseUrl = 'https://backend-production-91e4.up.railway.app';
  static const String baseUrlDev = 'https://dev-api-base-url.com/api/';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Endpoints
  static const String login = 'https://backend-production-91e4.up.railway.app/login/jwt';
  static const String register = 'auth/register';
  static const String refreshToken = 'auth/refresh-token';
  static const String logout = 'auth/logout';
  static const String profile = 'user/profile';
  static const String updateProfile = 'user/update-profile';
}