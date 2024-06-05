import 'package:get/get.dart';

import '../controllers/detailmotoradmin_controller.dart';

class DetailmotoradminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailmotoradminController>(
      () => DetailmotoradminController(),
    );
  }
}
