import 'package:easilybecho/core/extensions/context_extension.dart';
import 'package:easilybecho/core/navigation/routes/app_routes_paths.dart';
import 'package:easilybecho/views/main/bottom_navigation/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  MainShell({super.key, required this.child});

  final List<String> _routes = [
    AppRoutesPaths.dashboardPage,
    AppRoutesPaths.inventoryPage,
    AppRoutesPaths.billPage,
    AppRoutesPaths.salesPage,
    AppRoutesPaths.duesPage,
    AppRoutesPaths.accountPage,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            final currentLocation = GoRouterState.of(context).uri.toString();

            final homeRoute = _routes[0];

            // If not on home → go home
            if (!currentLocation.startsWith(homeRoute)) {
              context.read<BottomNavCubit>().changeTab(0);
              context.go(homeRoute);
              return;
            }

            // If already on home → show exit dialog
            final shouldExit = await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Exit App"),
                content: const Text("Do you want to exit this app?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Yes"),
                  ),
                ],
              ),
            );

            if (shouldExit == true) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              enableFeedback: true,
              type: BottomNavigationBarType.shifting,
              onTap: (index) {
                context.read<BottomNavCubit>().changeTab(index);
                context.go(_routes[index]);
              },
              selectedItemColor: context.theme.primaryColor,
              backgroundColor: Colors.black,
              landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "dashboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory),
                  label: "Inventory",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long),
                  label: "Bills",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.sell), label: "Sales"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  label: "Dues",
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: "Account",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
