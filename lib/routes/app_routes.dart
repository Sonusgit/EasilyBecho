class AppRoutes {
  // Authentication Routes
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';

  // Main App Routes
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static const String fiveStepform = '/fiveStepform';

  /// other screens
  static const billScreen = '/bill_screen';
  static const billsLastMonth = '/bills_last_month';

  // Error Routes
  static const String notFound = '/404';
  static const String error = '/error';

  // Get all routes as a list for easy reference
  static List<String> get allRoutes => [
    splash,
    welcome,
    login,
    signup,
    resetPassword,
    verifyEmail,
    dashboard,
    profile,
    settings,
    billScreen,
    notFound,
    error,
  ];
}
