import 'package:easilybecho/controllers/profile_controller.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:easilybecho/utility/components/components.dart';
import 'package:easilybecho/utility/const/app_colors.dart';
import 'package:easilybecho/utility/shared_preferences_utility.dart';
import 'package:easilybecho/utility/utility_helper/validator_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:easilybecho/controllers/auth_controller.dart';
import 'package:easilybecho/services/api_service.dart';
import 'package:easilybecho/utility/urls/urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: authController.loginFormKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Components.buildTextformField(
                        label: 'email',
                        controller: authController.emailController,
                        validator: ValidatorHelper.isValidEmail,
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Components.buildTextformField(
                        label: 'password',
                        controller: authController.passwordController,
                        validator: ValidatorHelper.isValidPassword,
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ],
                  ),

                  Obx(() {
                    return Row(
                      children: [
                        Components.buildElevatedButton(
                          isLoading: authController.isLoading.value,
                          onPressed: () {
                            // Get.toNamed(AppRoutes.dashboard);
                            authController.login();
                          },
                          label: 'login',
                        ),
                      ],
                    );
                  }),

                  Row(
                    children: [
                      Components.buildElevatedButton(
                        onPressed: () {
                          // Get.toNamed(AppRoutes.dashboard);
                          ApiService.requestGetApi(
                            url: Urls.logout,
                            token: true,
                          );
                        },
                        label: 'logout',
                      ),
                    ],
                  ),
                  //  Components.buildElevatedButton(
                  //   onPressed: () {
                  //     Get.toNamed(AppRoutes.dashboard);
                  //     // ApiService.requestGetApi(url: Urls.currentUser, token: true);
                  //   },
                  //   label: 'dashboard',
                  // ),
                  Components.buildCard(child: Text('This is a card')),
                  Row(
                    children: [
                      Components.buildElevatedButton(
                        onPressed: () async {
                          // ApiService.requestGetApi(
                          //   url: Urls.userslist,
                          //   token: true,
                          // );

                          // Get.toNamed(AppRoutes.dashboard);
                          print(await SharedPreferencesUtility.getUserToken());
                        },
                        label: 'Go to Dashboard',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Components.buildElevatedButton(
                        label: 'clear token',
                        color: AppColors.errorColor,
                        icon: FontAwesomeIcons.trash,

                        // iconColor: Colors.green,
                        onPressed: () async {
                          await SharedPreferencesUtility.clearAll();
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Components.buildElevatedButton(
                        label: 'bills',
                        onPressed: () {
                          Get.toNamed(AppRoutes.billScreen);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
