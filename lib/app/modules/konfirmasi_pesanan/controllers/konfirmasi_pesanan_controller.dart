import 'package:flutter/material.dart';
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

  konfirmasiPesanan(String even, String pesananID, String status) async {
    if (status == "Menunggu Konfirmasi") {
      if (even == "terima") {
        await firestoreService.updatePesananStatus(pesananID, "Diterima");

        Get.snackbar(
          "Sukses",
          "Pesanan telah Diterima",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        await firestoreService.updatePesananStatus(pesananID, "Ditolak");
        Get.snackbar(
          "Sukses",
          "Pesanan telah Ditolak",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } else {
      if (even == "kembalikan") {
        await firestoreService.updatePesananStatus(pesananID, "Dikembalikan");
        Get.snackbar(
          "Sukses",
          "Pesanan telah dikembalikan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        await firestoreService.updatePesananStatus(pesananID, "Dibatalkan");
        Get.snackbar(
          "Sukses",
          "Pesanan telah dibatalkan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    }
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
