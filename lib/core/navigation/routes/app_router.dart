import 'package:easilybecho/core/navigation/app_key.dart';
import 'package:easilybecho/core/navigation/app_navigators.dart';
import 'package:easilybecho/core/navigation/routes/app_routes_paths.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();

  static void navigateToLogin() {
    AppNavigators.go(AppRoutesPaths.login);
  }

  static void navigateToHome() {
    AppNavigators.go(AppRoutesPaths.bottomNavigationPage);
  }
}
