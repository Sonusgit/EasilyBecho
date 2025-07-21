import 'package:get/get.dart';
import 'package:easilybecho/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController(), permanent: true);
  }
}
