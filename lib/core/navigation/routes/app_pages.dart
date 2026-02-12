import 'package:easilybecho/core/navigation/app_key.dart';
import 'package:easilybecho/core/navigation/routes/app_routes_paths.dart';
import 'package:easilybecho/learn_bloc/counter_app/views/counter_page.dart';
import 'package:easilybecho/learn_bloc/image_picker/image_picker_screen.dart';
import 'package:easilybecho/learn_bloc/switch_example/views/switch_example_page.dart';
import 'package:easilybecho/learn_bloc/todo/view/to_do_screen.dart';
import 'package:easilybecho/views/features/auth/presentation/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppPages {
  static GoRouter routes = GoRouter(
    navigatorKey: AppKey.navigatorKey,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Error: Route not found'))),
    initialLocation: AppRoutesPaths.login,
    routes: [
      GoRoute(
        path: AppRoutesPaths.counterApp,
        builder: (context, state) {
          return CounterPage();
        },
      ),
      GoRoute(
        path: AppRoutesPaths.switchExample,
        builder: (_, state) => SwitchExamplePage(),
      ),
      GoRoute(
        path: AppRoutesPaths.imagePickerPage,
        builder: (_, state) => ImagePickerPage(),
      ),
      GoRoute(
        path: AppRoutesPaths.toDoPage,
        builder: (_, state) => ToDoPage(),
      ),


      //  App Page Start Here
       
        GoRoute(
        path: AppRoutesPaths.login,
        builder: (_, state) => LoginPage(),
      ),

    ],
  );
}
