import 'package:easilybecho/core/utility/utility_screen/not_network_screen.dart';
import 'package:easilybecho/views/features/auth/presentation/login_screen.dart';
import 'package:easilybecho/views/features/dashboard/presentation/dashboard_screen.dart';
import 'package:get/route_manager.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:easilybecho/views/features/splash/splash_screen.dart';

class AppPages {
  static const String initial = AppRoutes.splash;

  static final routes = [
    // Splash Screen Route
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300),
    ),

    //loginScreen Route
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300),
    ),
    
     GetPage(
      name: AppRoutes.dashboardScreen,
      page: () => DashboardScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300),
    ),
     GetPage(
      name: AppRoutes.noInternetConnection,
      page: () => NotNetworkScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300),
    ),
    
  ];
}
