import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetController extends GetxController {
  TextEditingController emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Tautan reset password dikirimkan ke email Anda');
    } else {
      Get.snackbar('Error', 'Please enter a valid email');
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
}
