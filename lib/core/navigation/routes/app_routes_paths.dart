class AppRoutesPaths {
  AppRoutesPaths._();
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

  // inventory management
  static const String inventoryPage = '/inventory_page';
  // product return management
  static const String productReturnPage = '/product_return_page';
  // bills management
  static const String billPage = '/bill_page';
  static const billsLastMonthCards = '/bills_last_month_cards';

  // sales management
  static const String salesPage = '/sales_page';
  // dues management
  static const String duesPage = '/dues_page';
  // account management
  static const String accountPage = '/account_page';

  // customer management
  static const String customerPage = '/customer_page';

  // Hsn management
  static const String hsnPage = '/hsn_page';

  // shop management
  static const String shopPage = '/shop_page';

  // subscription management
  static const String subscriptionPage = '/subscription_page';

  // Error Routes
  static const String noInternetConnection = '/no-internet-connection';
  static const String notFound = '/404';
  static const String error = '/error';

  /// other Pages

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
     // inventory management
    inventoryPage,

    // bills management
    billPage,
    billsLastMonthCards,

    // sales management
    salesPage,

    // dues management
    duesPage,

    // account management
    accountPage,

    // customer management
    customerPage,

    // hsn management
    hsnPage,

    // shop management
    shopPage,

    // subscription management
    subscriptionPage,

   
    notFound,
    error,
  ];
}
