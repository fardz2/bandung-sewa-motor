import 'package:get/get.dart';

import '../../../helper/auth_service.dart';
import '../../../helper/firestore_service.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var selectedCategory = 'All'.obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  getUserData() {
    final userUID = authService.user.value?.uid;
    if (userUID != null) {
      return firestoreService.getUserStream(userUID);
    } else {
      return null;
    }
  }

  // Get all motorbike
  getAllMotorbike() {
    return firestoreService.getAllTersediaMotorbike();
  }

  // Get motorbike by category
  getMotorbikeByCategory() {
    if (selectedCategory.value == 'All') {
      return firestoreService.getAllTersediaMotorbike();
    } else {
      return firestoreService.getMotorTersediaByMerek(selectedCategory.value);
    }
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
