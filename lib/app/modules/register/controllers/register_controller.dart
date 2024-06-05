import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
