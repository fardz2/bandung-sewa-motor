import 'package:get/get.dart';

import '../controllers/metode_bayar_controller.dart';

class MetodeBayarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MetodeBayarController>(
      () => MetodeBayarController(),
    );
  }
}
