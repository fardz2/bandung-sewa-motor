import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SewamotorController extends GetxController {
  //TODO: Implement SewamotorController

  final count = 0.obs;
  final motorID = Get.arguments;
  final firestoreService = Get.put(FirestoreService());
  final opsi = "ambil".obs;
  final ongkir = 10000.obs;
  final lokasi_antar = TextEditingController();
  void selectOption(String opsi) {
    this.opsi.value = opsi;
  }

  int totalHarga(int hargaMotor) {
    return opsi.value == "antar" ? hargaMotor + ongkir.value : hargaMotor;
  }

  getDetailMotor() {
    return firestoreService.getDetailMotor(motorID);
  }
}
