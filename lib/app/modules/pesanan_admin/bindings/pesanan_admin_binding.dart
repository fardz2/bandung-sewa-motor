import 'package:get/get.dart';

import '../controllers/pesanan_admin_controller.dart';

class PesananAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesananAdminController>(
      () => PesananAdminController(),
    );
  }
}
