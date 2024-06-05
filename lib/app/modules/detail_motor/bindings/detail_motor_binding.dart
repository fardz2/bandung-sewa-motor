import 'package:get/get.dart';

import '../controllers/detail_motor_controller.dart';

class DetailMotorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMotorController>(
      () => DetailMotorController(),
    );
  }
}
