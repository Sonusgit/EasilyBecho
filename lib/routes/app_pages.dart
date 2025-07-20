import 'package:get/route_manager.dart';
import 'package:smartbecho/bindings/auth_binding.dart';
import 'package:smartbecho/bindings/dashboard_baindg.dart';
import 'package:smartbecho/routes/app_routes.dart';
import 'package:smartbecho/views/auth/login_screen.dart';
import 'package:smartbecho/views/dashboard/dashboard_screen.dart';

class AppPages {
  static const String initial = AppRoutes.login;

  static final routes = [

    GetPage(name: AppRoutes.login ,
     page: () => LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300)
     ),

     // dashboard route
     GetPage(name: AppRoutes.dashboard,
     page: () =>DashboardScreen(),
      binding: DashboardBaindg(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 300)
     ),
     
  ];
}
