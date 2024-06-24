import 'package:bandung_sewa_motor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/auth_service.dart';
import '../../../helper/firestore_service.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();
  var obscureText = true.obs;
  var konfirmasiObscureText = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  void toggleKonfirmasiPasswordVisibility() {
    konfirmasiObscureText.value = !konfirmasiObscureText.value;
  }

  final formKey = GlobalKey<FormState>();
  final namaLengkapController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final noHpController = TextEditingController();

  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  void register() async {
    isLoading.value = true;
    try {
      await authService.register(
        namaLengkapController.text,
        emailController.text,
        noHpController.text,
        passwordController.text,
      );
      await authService.logoutReg();
      Get.snackbar('Success', 'Akun berhasil dibuat, Silahkan login',
          colorText: Colors.white, backgroundColor: Colors.green);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
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
    namaLengkapController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    noHpController.dispose();

    super.onClose();
  }
}
