import 'package:bandung_sewa_motor/app/helper/auth_service.dart';
import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';

import 'package:get/get.dart';

class SearchMotorController extends GetxController {
  final firestoreService = Get.put(FirestoreService());
  final authService = Get.put(AuthService());
  final search = "".obs;
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

  getMotorSearch(String search) {
    return firestoreService.getMotorSearchStream(search);
  }
}
