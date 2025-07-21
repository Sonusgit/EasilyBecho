import 'package:get/get.dart';
import 'package:easilybecho/models/profile_model.dart';
import 'package:easilybecho/services/api_service.dart';
import 'package:easilybecho/utils/urls/urls.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  Rxn<ProfileModel> profile = Rxn<ProfileModel>();

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchProfile();
  // }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      // Assuming ApiService.requestGetApi returns a ProfileModel
      final response = await ApiService.requestGetApi<ProfileModel>(
        url: Urls.currentUser,
        token: Urls.token,
        fromJson: (json) => ProfileModel.fromJson(json),
      );
      if (response != null) {
        profile.value = response;
        isLoading.value = false;
      } else {
        isLoading.value = false;
        Get.snackbar('Error', 'Failed to load profile');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
