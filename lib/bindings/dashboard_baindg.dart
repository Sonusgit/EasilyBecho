import 'package:get/get.dart';
import 'package:smartbecho/controllers/dashboard_controller.dart';

class DashboardBaindg extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController(), permanent: true);
  }
}
