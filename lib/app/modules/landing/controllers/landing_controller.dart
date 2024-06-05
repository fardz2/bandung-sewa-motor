import 'package:bandung_sewa_motor/app/modules/profile_pelanggan/controllers/profile_pelanggan_controller.dart';
import 'package:get/get.dart';

class LandingController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    Get.put(ProfilePelangganController());
    super.onInit();
  }


}
