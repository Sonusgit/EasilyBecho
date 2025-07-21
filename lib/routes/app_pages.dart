import 'package:get/route_manager.dart';
import 'package:easilybecho/bindings/auth_binding.dart';
import 'package:easilybecho/bindings/dashboard_baindg.dart';
import 'package:easilybecho/bindings/profile_binding.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:easilybecho/views/auth/login_screen.dart';
import 'package:easilybecho/views/dashboard/dashboard_screen.dart';
import 'package:easilybecho/views/profile/profile_screen.dart';
import 'package:easilybecho/views/splash/splash_screen.dart';

class AppPages {
  static const String initial = AppRoutes.login;

  static final routes = [
    // Splash Screen Route
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300),
    ),

    // dashboard route
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBaindg(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300),
    ),
    // profile route
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];
}
