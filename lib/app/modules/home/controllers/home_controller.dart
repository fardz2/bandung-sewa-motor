import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
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
}
