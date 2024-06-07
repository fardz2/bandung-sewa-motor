import 'package:get/get.dart';
import '../../home_admin/controllers/home_admin_controller.dart';
import '../../profile_admin/controllers/profile_admin_controller.dart';

class LandingAdminController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    Get.put(HomeAdminController());
    Get.put(ProfileAdminController());
    super.onInit();
  }

  @override
  void onReady() {
    changeTabIndex(0);
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<HomeAdminController>();
    Get.delete<ProfileAdminController>();
    super.onClose();
  }
}
