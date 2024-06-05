import 'package:get/get.dart';

import '../../home_admin/controllers/home_admin_controller.dart';

class LandingAdminController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    Get.put(HomeAdminController());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<HomeAdminController>();
    super.onClose();
  }
}
