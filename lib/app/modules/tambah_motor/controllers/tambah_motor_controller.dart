import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahMotorController extends GetxController {
  //TODO: Implement TambahMotorController

  List<String> merekOptions = ['Honda', 'Yamaha', 'Suzuki', 'Kawasaki'];
  Rx<String> selectedMerek = 'Honda'.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final namaMotor = TextEditingController();
  final jumlahMotor = TextEditingController();
  final hargaMotor = TextEditingController();
  final cc = TextEditingController();
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
    namaMotor.dispose();
    jumlahMotor.dispose();
    hargaMotor.dispose();
    cc.dispose();
    super.onClose();
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      // Misalnya, tambahkan motor
    }
  }

  void merekChanged(value) {
    selectedMerek.value = value.toString();
  }
}
