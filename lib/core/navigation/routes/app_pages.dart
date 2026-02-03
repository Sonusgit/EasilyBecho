import 'package:easilybecho/core/navigation/app_key.dart';
import 'package:easilybecho/core/navigation/routes/app_routes_paths.dart';
import 'package:easilybecho/learn_bloc/counter_app/views/counter_page.dart';
import 'package:easilybecho/learn_bloc/switch_example/views/switch_example_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppPages {
  static GoRouter routes = GoRouter(
    navigatorKey: AppKey.navigatorKey,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Error: Route not found'))),
    initialLocation: AppRoutesPaths.switchExample,
    routes: [
      GoRoute(path: AppRoutesPaths.counterApp, builder: (context, state) {
        return CounterPage();
      }, ),
      GoRoute(
     
        path: AppRoutesPaths.switchExample,
        builder: (_, state) => SwitchExamplePage(),
      ),
    ],
  );
}
