class AppRoutesNames {
  AppRoutesNames._();
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

  // inventory management
  static const String inventoryPage = 'inventory_page';
  // product return management
  static const String productReturnPage = 'product_return_page';
  // bills management
  static const String billPage = 'bill_page';
  static const billsLastMonthCards = 'bills_last_month_cards';

  // sales management
  static const String salesPage = 'sales_page';
  // dues management
  static const String duesPage = 'dues_page';
  // account management
  static const String accountPage = 'account_page';

  // customer management
  static const String customerPage = 'customer_page';

  // Hsn management
  static const String hsnPage = 'hsn_page';

  // shop management
  static const String shopPage = 'shop_page';

  // subscription management
  static const String subscriptionPage = 'subscription_page';

  //  other screens

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
    fiveStepform,

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

    //  Error Routes
    noInternetConnection,
    notFound,
    error,
  ];
}
