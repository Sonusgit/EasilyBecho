import 'package:easilybecho/controllers/bill_controller.dart';
import 'package:get/instance_manager.dart';

class BillBinding extends Bindings{
  @override
  void dependencies() {
       Get.put<BillController>(BillController(), permanent: true);

  }
}