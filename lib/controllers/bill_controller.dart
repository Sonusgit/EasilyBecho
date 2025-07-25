import 'package:easilybecho/models/bill_last_month_model.dart';
import 'package:easilybecho/services/api_service.dart';
import 'package:easilybecho/utility/urls/urls.dart';
import 'package:get/state_manager.dart';

class BillController extends GetxController {
  // Rxn<ProfileModel> profile = Rxn<ProfileModel>();

  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchBillsLastmonth();
  }

  ///BilsLast
  Rxn<BillsLastMonthModel> bilsMonthData = Rxn<BillsLastMonthModel>();
  Future<void> fetchBillsLastmonth() async {
    isLoading.value = true;
    try {
      final response = await ApiService.requestGetApi(
        url: Urls.billsLastmonth,
        token: Urls.token,
        fromJson: (json) => BillsLastMonthModel.fromJson(json),
      );
      if (response != null) {
        print(' sagklsgh${response.payload}');
        bilsMonthData.value = response;
        isLoading.value = false;
      }
    } catch (e) {
      print('fail$e');
    } finally {
      isLoading.value = false;
    }
  }
}
