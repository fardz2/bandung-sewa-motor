import 'package:get/get.dart';

import '../controllers/detail_pembayaran_controller.dart';

class DetailPembayaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPembayaranController>(
      () => DetailPembayaranController(),
    );
  }
}
