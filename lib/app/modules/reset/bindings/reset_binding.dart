import 'package:get/get.dart';

import '../controllers/reset_controller.dart';

class ResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetController>(
      () => ResetController(),
    );
  }
}
