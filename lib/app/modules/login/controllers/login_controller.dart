import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/auth_service.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  var obscureText = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final authService = Get.put(AuthService());

  void login() async {
    isLoading.value = true;
    try {
      await authService.login(
        emailController.text,
        passwordController.text,
      );
      isLoading.value = false;
      if (emailController.text == "admin@gmail.com") {
        Get.offAllNamed(Routes.LANDING_ADMIN);
      } else {
        Get.offAllNamed(Routes.LANDING);
      }
    } catch (e) {
      null;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    if (authService.user.value != null) {
      if (authService.user.value!.email == "admin@gmail.com") {
        Get.offAllNamed(Routes.LANDING_ADMIN);
      } else {
        Get.offAllNamed(Routes.LANDING);
      }
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
