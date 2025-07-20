import 'package:get/get.dart';
import 'package:smartbecho/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AuthController>(() => AuthController());
    Get.put<AuthController>(AuthController(),permanent: true);
  }
}
