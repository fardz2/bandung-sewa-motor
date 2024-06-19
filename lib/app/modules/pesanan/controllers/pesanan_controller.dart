import 'package:bandung_sewa_motor/app/helper/auth_service.dart';
import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:bandung_sewa_motor/app/models/pesanan_model.dart';
import 'package:get/get.dart';

class PesananController extends GetxController {
  var enabled = true.obs;
  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());
  var selectedCategory = "All".obs;
  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  Stream<List<PesananModel>> getPesananByUserIDData() {
    final userUID = authService.user.value?.uid;
    if (userUID != null) {
      if (selectedCategory.value == 'All') {
        return firestoreService.getPesananByUserIDStream(userUID);
      } else {
        return firestoreService.getPesananByUserIDStatusStream(
            userUID, selectedCategory.value);
      }
    } else {
      return Stream.value([]);
    }
  }

  Stream<MotorModel> getDetailMotor(String motorID) {
    return firestoreService.getDetailMotor(motorID);
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
