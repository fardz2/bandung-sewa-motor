import 'package:bandung_sewa_motor/app/helper/auth_service.dart';
import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:bandung_sewa_motor/app/models/pesanan_model.dart';
import 'package:get/get.dart';

class DetailPesananController extends GetxController {
  final pesananID = Get.arguments;

  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  Stream<PesananModel> getDetailPesanan() {
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
