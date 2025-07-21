import 'package:get/get.dart';
import 'package:easilybecho/controllers/dashboard_controller.dart';

class DashboardBaindg extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController(), permanent: true);
  }
}
