import 'package:get/get.dart';

import '../controllers/landing_admin_controller.dart';

class LandingAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingAdminController>(
      () => LandingAdminController(),
    );
  }
}
