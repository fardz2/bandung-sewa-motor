import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../helper/auth_service.dart';
import '../../../helper/firestore_service.dart';

class ProfileAdminController extends GetxController {
  static ProfileAdminController get to => Get.find();

  final isLoading = false.obs;

  final authService = Get.put(AuthService());

  Future<void> logout() async {
    isLoading.value = true;
    await FirebaseMessaging.instance
        .unsubscribeFromTopic(authService.user.value!.uid);
    await authService.logout();
    isLoading.value = false;
  }

  final firestoreService = Get.put(FirestoreService());

  getUserData() {
    final userUID = authService.user.value?.uid;
    if (userUID != null) {
      return firestoreService.getUserStream(userUID);
    } else {
      return null;
    }
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
