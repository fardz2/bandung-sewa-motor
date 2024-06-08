import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:bandung_sewa_motor/app/routes/app_pages.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailmotoradminController extends GetxController {
  //TODO: Implement DetailmotoradminController

  final motorID = Get.arguments;
  final firestoreService = Get.put(FirestoreService());
  final FirebaseStorage _storage = FirebaseStorage.instance;
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

  void hapusMotor(String motorID, String gambarUrl) async {
    try {
      Reference imageRef = _storage.refFromURL(gambarUrl);
      await imageRef.delete();
      await firestoreService.deleteMotor(motorID);
      Get.back();
      Get.snackbar(
        "Sukses",
        "Data motor berhasil dihapus",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offNamed(Routes.LANDING_ADMIN);
    } catch (e) {
      Get.snackbar(
        "error",
        "Data motor berhasil dihapus",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
