import 'package:bandung_sewa_motor/app/helper/auth_service.dart';
import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:bandung_sewa_motor/app/models/pesanan_model.dart';
import 'package:get/get.dart';

class PesananAdminController extends GetxController {
  //TODO: Implement PesananAdminController

  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  Stream<List<PesananModel>> getAllPesanan() {
    return firestoreService.getAllPesananStream();
  }

  Stream<MotorModel> getDetailMotor(String motorID) {
    return firestoreService.getDetailMotor(motorID);
  }

  Stream<List<Map<String, dynamic>>> fetchPesananWithDetails() async* {
    List<Map<String, dynamic>> combinedList = [];
    List<PesananModel> pesananList = await getAllPesanan().first;

    for (var pesanan in pesananList) {
      MotorModel motor = await getDetailMotor(pesanan.motorID).first;
      combinedList.add({
        'pesanan': pesanan,
        'motor': motor,
      });
    }

    yield combinedList;
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
