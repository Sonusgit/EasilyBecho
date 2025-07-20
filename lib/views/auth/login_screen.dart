import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:smartbecho/controllers/auth_controller.dart';
import 'package:smartbecho/routes/app_routes.dart';
import 'package:smartbecho/utils/components/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

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

              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.dashboard);
                },
                child: const Text('dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
