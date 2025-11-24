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
          return NotNetworkScreen();
        }
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Dashboard"),
              floating: true,
              pinned: false,
            ),

            SliverAppBar(
              title: Text("Statistics"),
              floating: true,
              pinned: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: Container(color: Colors.red, height: 5),
              ),
            ),

            SliverToBoxAdapter(child: Center(child: Text("Hello"))),

            SliverAppBar(
              title: Text("Statistics"),
              floating: true,
              pinned: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: Container(color: Colors.red, height: 5),
              ),
            ),

            SliverList.builder(
              itemBuilder: (context, index) =>
                  Card(child: Container(height: 20)),
              itemCount: 30,
            ),

            SliverToBoxAdapter(
              child: Card(
                child: Row(
                  children: [
                    Container(
                      width:
                          MediaQuery.of(context).size.width * 0.5, // 60% width
                      height: MediaQuery.of(context).size.height * .4,
                      color: Colors.red, // just to see area
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
