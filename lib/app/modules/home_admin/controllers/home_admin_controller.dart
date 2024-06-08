import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../helper/auth_service.dart';
import '../../../helper/firestore_service.dart';

class HomeAdminController extends GetxController {
  static HomeAdminController get to => Get.find();

  //format currency
  String formatCurrency(int value) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(value);
  }

  // Selected category
  var selectedCategory = 'All'.obs;
  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  // Instance of AuthService and FirestoreService
  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  // Get user data
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
    return firestoreService.getAllMotorbike();
  }

  // Get motorbike by category
  getMotorbikeByCategory() {
    if (selectedCategory.value == 'All') {
      return firestoreService.getAllMotorbike();
    } else {
      return firestoreService.getMotorByMerek(selectedCategory.value);
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
