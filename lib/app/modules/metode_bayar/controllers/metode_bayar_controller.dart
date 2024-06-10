import 'package:get/get.dart';

import '../../../helper/firestore_service.dart';

class MetodeBayarController extends GetxController {
  String pesananID = Get.arguments;

  final firestoreService = Get.put(FirestoreService());

  getDetailPesanan() {
    return firestoreService.getPesananByIdStream(pesananID);
  }

  getMotorById(String motorID) {
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
