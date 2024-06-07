import 'package:get/get.dart';

import '../controllers/tambah_motor_controller.dart';

class TambahMotorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahMotorController>(
      () => TambahMotorController(),
    );
  }
}
