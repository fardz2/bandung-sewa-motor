import 'package:get/get.dart';

import '../controllers/bukti_pembayaran_controller.dart';

class BuktiPembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuktiPembayaranController>(
      () => BuktiPembayaranController(),
    );
  }
}
