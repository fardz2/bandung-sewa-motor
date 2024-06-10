import 'package:get/get.dart';

import '../../../helper/auth_service.dart';
import '../../../helper/firestore_service.dart';

class ProfilePelangganController extends GetxController {
  static ProfilePelangganController get to => Get.find();

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

  logout() {
    authService.logout();
  }

  final count = 0.obs;
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

  void increment() => count.value++;
}
