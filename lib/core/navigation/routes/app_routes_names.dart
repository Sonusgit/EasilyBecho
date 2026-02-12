class AppRoutesNames {
  //Test bloc and learn bloc 
  static const String counterApp = 'counter_app';
  static const String switchExample = 'switch_example';
  static const imagePickerScreen = 'image_picker_screen';
  static const toDoScreen = 'toDoScreen';
  //  Authentication Routes
  static const String splash = 'splash';
  static const String welcome = 'welcome';
  static const String loginScreen = 'login_screen';
  static const String signup = 'signup';
  static const String resetPassword = 'reset-password';
  static const String verifyEmail = 'verify-email';

  //  Main App Routes
  static const String bottomNavigationScreen = 'bottom_navigation';
  static const String dashboardScreen = 'dashboard_screen';
  static const String profile = 'profile';
  static const String settings = 'settings';

  static const String fiveStepform = 'fiveStepform';

  //  other screens
  static const billScreen = 'bill_screen';
  static const billsLastMonthCards = 'bills_last_month_cards';

  //  Error Routes
  static const String noInternetConnection = 'no-internet-connection';
  static const String notFound = '404';
  static const String error = 'error';

  //  Get all routes as a list for easy reference
  static List<String> get allRoutes => [
    counterApp,
    switchExample,
    splash,
    welcome,
    loginScreen,
    signup,
    resetPassword,
    verifyEmail,
    dashboardScreen,
    profile,
    settings,
    billScreen,
    notFound,
    error,
  ];
}
