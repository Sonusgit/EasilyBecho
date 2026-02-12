class  AppConfig {
   String get baseUrl =>
      'https://backend-production-91e4.up.railway.app';
  // static const String token =
      // 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdXBlckFkbWluQGdtYWlsLmNvbSIsImV4cCI6MTc1MzczMTExMiwiaWF0IjoxNzUzMTI2MzEyfQ.emjb_TARjXdjmACGb7rtvxHj3ce85ZdfI948WdLKajA';

   String get loginUrl => '$baseUrl/login/jwt';
   String get logout => '$baseUrl/logout';
 

  // Base URLs
  static const String baseUrlDev = 'https://dev-api-base-url.com/api/';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Endpoints
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String refreshToken = 'auth/refresh-token';
  static const String profile = 'user/profile';
  static const String updateProfile = 'user/update-profile';

  
}
