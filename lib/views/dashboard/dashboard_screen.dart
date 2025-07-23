import 'package:easilybecho/controllers/dashboard_controller.dart';
import 'package:easilybecho/utility/components/components.dart';
import 'package:easilybecho/utility/const/app_colors.dart';
import 'package:easilybecho/utility/shared_preferences_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final dashboardController = Get.find<DashboardController>();
    final dashboardController = Get.find<DashboardController>();
    return Scaffold(
      appBar: AppBar(title: Text('Dashbrod')),
      drawer: Drawer(
        backgroundColor: AppColors.appBarColor,
        child: ListView(
          children: [
            Components.buildCard(
              child: Text('text'),

              onTap: () => Get.toNamed('/login'),
            ),
          ],
        ),
      ),

      body: Center(
        child: Column(
          children: [
            Text('dashbrode'),
            Obx(
              () => Text('User Token: ${dashboardController.userToken.value}'),
            ),
            Obx(() => Text('User Token: ${dashboardController.loginDate}')),
            Row(
              children: [
                Components.buildElevatedButton(
                  label: 'logout',
                  onPressed: () async {
                    await SharedPreferencesUtility.clearAll();
                    dashboardController.clearData();
                    Get.offAllNamed('/login'); // Redirect to login screen
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
