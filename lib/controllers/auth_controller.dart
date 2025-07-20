import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
   

   Rx<TextEditingController> emailController = TextEditingController().obs;
   Rx<TextEditingController> passwordController = TextEditingController().obs;
}