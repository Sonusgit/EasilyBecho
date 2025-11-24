import 'package:easilybecho/core/common/CommonTextField.dart';
import 'package:easilybecho/core/validator/validator_helper.dart';
import 'package:easilybecho/views/features/auth/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.find<LoginController>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //HEADER
                const SizedBox(height: 10),
                Text(
                  'Login',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                //  FORMULARIO DE LOGIN
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      CommonTextField(
                        label: 'Email',
                        controller: controller.emailController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icon(Icons.mail),
                        validator: ValidatorHelper.isValidEmail,
                      ),

                      CommonTextField(
                        label: 'Password',
                        controller: controller.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.isPasswordVisible.value,
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            print(controller.isPasswordVisible);
                            controller.togglePasswordVisibility();
                          },
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.remove_red_eye_outlined,
                          ),
                        ),
                        validator: ValidatorHelper.isValidPassword,
                      ),
                    ],
                  ),
                ),
                LinearProgressIndicator(value:controller.isLoading.value ? 1:null),
                //BOTON DE INGRESO
                ElevatedButton(onPressed: () {
                  controller.login();
                }, child: controller.isLoading.value ? SizedBox(height: 25,width: 25, child: CircularProgressIndicator()) : const Text('LOGIN')),

                //LINK PARA REGISTRARSE
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(onPressed: () {}, child: Text('Register')),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
