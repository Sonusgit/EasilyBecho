import 'package:easilybecho/core/common/app_bar/common_app_bar.dart';
import 'package:easilybecho/core/common/charts/Pie_chart.dart';
import 'package:easilybecho/core/common/charts/bar_chart.dart';
import 'package:easilybecho/core/common/charts/line_charts.dart';
import 'package:easilybecho/core/common/charts/multi_line_chart.dart';
import 'package:easilybecho/core/extensions/button_extension.dart';
import 'package:easilybecho/core/extensions/url_launcher_extension.dart';
import 'package:easilybecho/core/helpers/toast/bottom_sheeth_elper.dart';
import 'package:easilybecho/core/utility/utility_screen/loading_screen.dart';
import 'package:easilybecho/core/utility/utility_screen/network_controller.dart';
import 'package:easilybecho/core/utility/utility_screen/not_network_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final NetworkController networkController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!networkController.isOnline.value) {
          return const LoadingScreen();
        } else if (!networkController.isOnline.value) {
          return NotNetworkScreen();
        }
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Dashboard"),
              floating: true,
              pinned: false,
            ),

            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: CommonHeaderDelegate(
                minHeight: 60,
                maxHeight: 60,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.primary,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Dashboard',
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SalesLineChart(),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SalesSplineChart(),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SalesRadialBar(),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomerPyramidChart(),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: MultiSplineChart(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomerDoughnutChart(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomerPieChart(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: YearlySalesBarChart(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    'dflkj'.toElevatedButton(
                      onPressed: () {
                        BottomSheetHelper.show(
                          context,
                          title: "Delete Item?",
                          content: Text(
                            "Are you sure you want to delete this item?",
                          ),
                          confirmText: "Delete",
                          onConfirm: () {
                            print("Item deleted!");
                            'https://www.youtube.com/'.openUrl();
                          },
                          cancelText: "Cancel",
                          onCancel: () {
                            print("Cancelled");
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: UrlLauncherExamples(),
              ),
            ),
          ],
        );
      }),
    );
  }
}
