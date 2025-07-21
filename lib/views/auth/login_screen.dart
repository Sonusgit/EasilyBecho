import 'package:easilybecho/controllers/profile_controller.dart';
import 'package:easilybecho/utils/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easilybecho/controllers/auth_controller.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:easilybecho/services/api_service.dart';
import 'package:easilybecho/utils/urls/urls.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Components.buildTextformField(
                label: 'email',
                controller: authController.emailController.value,
              ),
              Components.buildTextformField(
                label: 'password',
                controller: authController.passwordController.value,
              ),

              Components.buildElevatedButton(
                onPressed: () {
                  // Get.toNamed(AppRoutes.dashboard);
                  ApiService.requestGetApi(url: Urls.logout, token: Urls.token);
                },
                label: 'logout',
              ),

              Components.buildElevatedButton(
                onPressed: () {
                  // Get.toNamed(AppRoutes.dashboard);
                  ApiService.requestGetApi(url: Urls.login, token: Urls.token);
                },
                label: 'logout',
              ),
              Components.buildElevatedButton(
                onPressed: () {
                  Map data = {
                    // "email": "superAdmin@gmail.com",
                    // "password": "admin@1234",
                    "email": authController.emailController.value.text,
                    "password": authController.passwordController.value.text,
                  };
                  // Get.toNamed(AppRoutes.dashboard);
                  ApiService.requestPostApi(Urls.login, data);
                },
                label: 'login',
              ),
              Components.buildElevatedButton(
                label: 'profile',
                onPressed: () {
                  Get.toNamed(AppRoutes.profile);
                  // ApiService.requestGetApi(url: Urls.currentUser, token: Urls.token);
                  profileController.fetchProfile();
                },
              ),

              Components.buildElevatedButton(
                onPressed: () {
                  // Get.toNamed(AppRoutes.dashboard);
                  print(profileController.isLoading.value);
                  ApiService.requestGetApi(
                    url: Urls.currentUser,
                    token: Urls.token,
                  );
                },
                label: 'profile',
                isLoading: profileController.isLoading.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
