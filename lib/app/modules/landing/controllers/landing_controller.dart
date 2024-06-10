import 'package:bandung_sewa_motor/app/modules/profile_pelanggan/controllers/profile_pelanggan_controller.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../pesanan/controllers/pesanan_controller.dart';

class LandingController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    Get.put(HomeController());
    Get.put(ProfilePelangganController());
    Get.put(PesananController());
    super.onInit();
  }

  @override
  void onReady() {
    changeTabIndex(0);
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<HomeController>();
    Get.delete<ProfilePelangganController>();
    Get.delete<PesananController>();
    super.onClose();
  }
}
