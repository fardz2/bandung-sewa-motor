import 'package:get/get.dart';

import '../../../helper/firestore_service.dart';

class KonfirmasiPesananController extends GetxController {
  static KonfirmasiPesananController get to => Get.find();

  final pesananID = Get.arguments;
  final firestoreService = Get.put(FirestoreService());

  getDetailPesanan() {
    return firestoreService.getPesananByIdStream(pesananID);
  }

  getUserData(String pelangganID) {
    return firestoreService.getUserStream(pelangganID);
  }

  getMotorData(String motorID) {
    return firestoreService.getDetailMotor(motorID);
  }

  getPembayaranData(String pembayaranID) {
    return firestoreService.getPembayaranByIdStream(pembayaranID);
  }

  @override
  void onInit() {
    getDetailPesanan();
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
