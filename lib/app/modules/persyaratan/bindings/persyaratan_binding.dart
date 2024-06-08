import 'package:get/get.dart';

import '../controllers/persyaratan_controller.dart';

class PersyaratanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersyaratanController>(
      () => PersyaratanController(),
    );
  }
}
