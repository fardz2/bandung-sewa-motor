import 'package:bandung_sewa_motor/app/modules/search_motor/controllers/search_controller.dart';
import 'package:get/get.dart';

class SearchMotorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMotorController>(
      () => SearchMotorController(),
    );
  }
}
