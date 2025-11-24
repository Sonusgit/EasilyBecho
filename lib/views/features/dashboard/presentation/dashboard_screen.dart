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
        }else if(!networkController.isOnline.value){
        return  NotNetworkScreen();
        }
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Dashboard"),
              floating: true,
              pinned: false,
            ),

        
          ],
        );
      }),
    );
  }
}
