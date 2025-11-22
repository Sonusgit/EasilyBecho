import 'package:easilybecho/core/utility/utility_screen/network_controller.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotNetworkScreen extends StatelessWidget {
  NotNetworkScreen({super.key});
final  NetworkController controller =Get.find<NetworkController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return chackConnection();
      }
    );
  }

  Scaffold chackConnection() {
    return controller.isOnline.value? Scaffold(
        body: Center(child: Text('Network Screen')),
      ):Scaffold(body: Center(child: Center(child: Column(
        children: [
          Text('Not Network Screen'),
          TextButton(onPressed: (){controller.chackNetworkConnection();
           // ignore: avoid_print
           controller.isOnline.value ? Get.offAll(AppRoutes.dashboardScreen):print("");
          }, child: Text('Try Again'))
        ],
      ))),);
  }
  }