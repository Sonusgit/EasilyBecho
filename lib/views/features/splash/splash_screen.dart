import 'dart:async';

import 'package:easilybecho/core/utility/utility_screen/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NetworkController networkController = Get.find<NetworkController>();
  @override
  void initState() {
    // Timer(Duration(seconds: 10), () => networkController.isOnline.value ? Get.toNamed(AppRoutes.noInternetConnection) : Get.toNamed(AppRoutes.loginScreen));
    // checkInternet();
    Timer(
  Duration(seconds: 3),
  () {
    networkController.isOnline.value
        ? Get.toNamed(AppRoutes.loginScreen)         // online
        : Get.toNamed(AppRoutes.noInternetConnection); // offline
  },
);

    super.initState();
  }
Future<void> checkInternet() async {
  bool connected = await InternetConnectionChecker.instance.hasConnection;

  Future.delayed(Duration(seconds: 3), () {
    if (!connected) {
      Get.toNamed(AppRoutes.noInternetConnection);
    } else {
      Get.toNamed(AppRoutes.loginScreen);
    }
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('this is splash Screen')));
  }
}
