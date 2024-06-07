import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SearchMotorController extends GetxController {
  //TODO: Implement DetailController
  final firestoreService = Get.put(FirestoreService());

  final search = "".obs;
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

  getMotorSearch(String search) {
    return firestoreService.getMotorSearchStream(search);
  }

  String formatNumber(int number) {
    if (number >= 1000 && number < 1000000) {
      return '${(number / 1000).toStringAsFixed(0)}K';
    } else if (number >= 1000000 && number < 1000000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else {
      return number.toString();
    }
  }
}
