import 'package:get/get.dart';

class HomeAdminController extends GetxController {
  static HomeAdminController get to => Get.find();
  var selectedCategory = 'All'.obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
