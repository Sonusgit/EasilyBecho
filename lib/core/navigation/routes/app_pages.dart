import 'package:easilybecho/core/navigation/app_key.dart';
import 'package:easilybecho/core/navigation/routes/app_routes_paths.dart';
import 'package:easilybecho/learn_bloc/counter_app/views/counter_page.dart';
import 'package:easilybecho/learn_bloc/image_picker/image_picker_screen.dart';
import 'package:easilybecho/learn_bloc/switch_example/views/switch_example_page.dart';
import 'package:easilybecho/learn_bloc/todo/view/to_do_screen.dart';
import 'package:easilybecho/views/features/Inventory_management/Inventory_management_page.dart';
import 'package:easilybecho/views/features/account_management/account_management_page.dart';
import 'package:easilybecho/views/features/auth/presentation/login_page.dart';
import 'package:easilybecho/views/features/bills_management/bills_management_page.dart';
import 'package:easilybecho/views/features/dashboard/presentation/dashboard_page.dart';
import 'package:easilybecho/views/features/dues_management/dues_management_page.dart';
import 'package:easilybecho/views/features/sales_management/sales_management_page.dart';
import 'package:easilybecho/views/main/bottom_navigation/bottom_nav_bloc.dart';
import 'package:easilybecho/views/main/bottom_navigation/bottom_nav_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppPages {
  static GoRouter routes = GoRouter(
    navigatorKey: AppKey.navigatorKey,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Error: Route not found'))),
    initialLocation: AppRoutesPaths.dashboardPage,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (_) => BottomNavCubit(),
            child: MainShell(child: child),
          );
        },
        routes: [
          GoRoute(
            path: AppRoutesPaths.dashboardPage,
            builder: (_, state) => const DashboardPage(),
          ),
          GoRoute(
            path: AppRoutesPaths.inventoryPage,
            builder: (_, state) => const InventoryManagementPage(),
          ),
          GoRoute(
            path: AppRoutesPaths.billPage,
            builder: (_, state) => const BillsManagementPage(),
          ),
          GoRoute(
            path: AppRoutesPaths.salesPage,
            builder: (_, state) => const SalesManagementPage(),
          ),
          GoRoute(
            path: AppRoutesPaths.duesPage,
            builder: (_, state) => const DuesManagementPage(),
          ),
          GoRoute(
            path: AppRoutesPaths.accountPage,
            builder: (_, state) => const AccountManagementPage(),
          ),
        ],
      ),
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
      GoRoute(path: AppRoutesPaths.toDoPage, builder: (_, state) => ToDoPage()),

      //  App Page Start Here
      GoRoute(path: AppRoutesPaths.login, builder: (_, state) => LoginPage()),
    ],
  );
}
