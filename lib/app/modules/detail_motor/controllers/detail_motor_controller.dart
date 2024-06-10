import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:get/get.dart';

class DetailMotorController extends GetxController {
  //TODO: Implement DetailMotorController

  final motorID = Get.arguments;
  final firestoreService = Get.put(FirestoreService());
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  getDetailMotor() {
    return firestoreService.getDetailMotor(motorID);
  }
}
