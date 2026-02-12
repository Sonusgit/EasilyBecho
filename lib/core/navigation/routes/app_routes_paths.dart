
class AppRoutesPaths {
  //Test bloc and learn bloc 
  static const String counterApp = '/counter_app';
  static const String switchExample = '/switch_example';
  // image_picker_Page.dart
  static const imagePickerPage = '/image_picker_Page';
  static const toDoPage = '/toDoPage';

  // Authentication Routes
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login_Page';
  static const String signup = '/signup';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';

  // Main App Routes
  static const String bottomNavigationPage = '/bottom_navigation';
  static const String dashboardPage = '/dashboard_Page';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static const String fiveStepform = '/fiveStepform';

  /// other Pages
  static const billPage = '/bill_Page';
  static const billsLastMonthCards = '/bills_last_month_cards';

  // Error Routes
  static const String noInternetConnection = '/no-internet-connection';
  static const String notFound = '/404';
  static const String error = '/error';

  // Get all routes as a list for easy reference
  static List<String> get allRoutes => [
    counterApp,
    switchExample,
    splash,
    welcome,
    login,
    signup,
    resetPassword,
    verifyEmail,
    dashboardPage,
    profile,
    settings,
    billPage,
    notFound,
    error,
  ];
}
