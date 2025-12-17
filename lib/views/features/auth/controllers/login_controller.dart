import 'package:easilybecho/core/helpers/toast/toast_helper.dart';
import 'package:easilybecho/services/routes_sreivce.dart';
import 'package:easilybecho/services/shared_preferences_helper.dart';
import 'package:easilybecho/views/features/auth/repo/login_repo.dart';
import 'package:easilybecho/views/features/auth/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginRepo _repo = LoginRepo();

  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rxn<LoginModel> loginResponse = Rxn<LoginModel>();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  RxString errorMessage = ''.obs;
  Future<void> login() async {
    try {
      isLoading.value = true;
      if (!formKey.currentState!.validate()) return;
      final response = await _repo.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      errorMessage.value = response?.data['message'] ?? '';
      if (response != null && response.statusCode == 200) {
        // Convert JSON to Model
        loginResponse.value = LoginModel.fromJson(response.data);

        errorMessage.value = loginResponse.value?.message ?? '';

        // Save Token
        final token = loginResponse.value?.payload.userToken;
        final refreshToken = loginResponse.value?.payload.refreshToken;

        if (token != null) SharedPreferencesHelper.setUserToken(token);
        if (refreshToken != null)
          SharedPreferencesHelper.setRefreshToken(refreshToken);

        SharedPreferencesHelper.setIsLoggedIn(true);
        ToastHelper.success('Login Successful!');
        RoutesSreivce.toBottomNavigationScreen();
      } else {
        ToastHelper.error(message: errorMessage.string);
      }
    } catch (e) {
      ToastHelper.error(message: errorMessage.string);
    } finally {
      isLoading.value = false;
    }
  }
}
