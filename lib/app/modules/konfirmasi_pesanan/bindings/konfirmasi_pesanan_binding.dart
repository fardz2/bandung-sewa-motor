import 'package:get/get.dart';

import '../controllers/konfirmasi_pesanan_controller.dart';

class KonfirmasiPesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KonfirmasiPesananController>(
      () => KonfirmasiPesananController(),
    );
  }
}
