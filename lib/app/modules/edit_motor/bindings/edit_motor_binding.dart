import 'package:get/get.dart';

import '../controllers/edit_motor_controller.dart';

class EditMotorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditMotorController>(
      () => EditMotorController(),
    );
  }
}
