import 'package:get/get.dart';

import '../controllers/profile_admin_controller.dart';

class ProfileAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileAdminController>(
      () => ProfileAdminController(),
    );
  }
}
