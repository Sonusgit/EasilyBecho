import 'package:easilybecho/utility/shared_preferences_utility.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxString userToken = ''.obs;
  RxList<int> loginDate = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadToken(); // Load token when the controller is initialized
  }

  void loadToken() async {
    String? token = await SharedPreferencesUtility.getUserToken();
    List<int>? date = await SharedPreferencesUtility.getLoginDate();
    if (token != null) {
      userToken.value = token;
    }
    if (date !=null) {
      loginDate.value= date.cast<int>();
    }
  }
  void clearData() {
  userToken.value = '';
  loginDate.value = [];
}

}
