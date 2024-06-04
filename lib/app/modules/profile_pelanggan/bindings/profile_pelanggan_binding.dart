import 'package:get/get.dart';

import '../controllers/profile_pelanggan_controller.dart';

class ProfilePelangganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePelangganController>(
      () => ProfilePelangganController(),
    );
  }
}
