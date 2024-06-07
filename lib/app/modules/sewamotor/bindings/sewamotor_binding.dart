import 'package:get/get.dart';

import '../controllers/sewamotor_controller.dart';

class SewamotorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SewamotorController>(
      () => SewamotorController(),
    );
  }
}
