import 'dart:math';

import 'package:easilybecho/models/auth_model.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:easilybecho/services/api_service.dart';
import 'package:easilybecho/utility/shared_preferences_utility.dart';
import 'package:easilybecho/utility/urls/urls.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  Map<String, dynamic> get data => {
    "email": emailController.text.trim(),
    "password": passwordController.text.trim(),
  };


  //   Map data = {
  //  "email": "superAdmin@gmail.com",
  // "password": "admin@1234"
  // };


  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    try {
      final response = await ApiService.requestPostApi(Urls.login, data);
      if (response != null) {
        isLoading.value = false;
        print('Login successful $response');
        final AuthModel authModel = AuthModel.fromJson(response);
        if (authModel.statusCode == 200 && authModel.payload != null) {
          await SharedPreferencesUtility.saveIsLoggedIn(true);
          String userToken = authModel.payload!.refreshToken!;
          List<int> loginDate = authModel.payload!.loginDate!;
          await SharedPreferencesUtility.saveUserToken(userToken);
          await SharedPreferencesUtility.saveLoginDate(loginDate);
           Get.toNamed(AppRoutes.dashboard);
        }
       
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}
