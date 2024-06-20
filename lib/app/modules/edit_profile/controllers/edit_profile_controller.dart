import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/auth_service.dart';
import '../../../helper/firestore_service.dart';

class EditProfileController extends GetxController {
  final userID = Get.arguments;
  final formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final noHpController = TextEditingController();
  final isLoading = false.obs;

  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  getDetailImage() {
    return firestoreService.getUserStream(userID);
  }

  getDetailUser() {
    firestoreService.getUser(userID).then((value) {
      if (value != null) {
        namaController.text = value.name;
        emailController.text = value.email;
        noHpController.text = value.phone;
      }
    });
  }

  var gambarUrl = XFile("").obs;

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    if (gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
    }
    if (pickedFile != null) {
      gambarUrl.value = pickedFile;
    }
  }

  Future<String> uploadFile(File image) async {
    final storageReference =
        FirebaseStorage.instance.ref().child('userPhoto/${image.path}');
    await storageReference.putFile(image);
    String returnURL = "";
    await storageReference.getDownloadURL().then(
      (fileURL) {
        returnURL = fileURL;
      },
    );
    return returnURL;
  }

  updateProfile() async {
    if (gambarUrl.value.path == "") {
      isLoading.value = true;
      await firestoreService.updateUserDetail(
        userID,
        namaController.text,
        emailController.text,
        noHpController.text,
        "",
      );
      Get.snackbar(
        "Sukses",
        "Data User berhasil diubah",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      namaController.clear();
      emailController.clear();
      noHpController.clear();
      gambarUrl.value = XFile("");
    } else {
      isLoading.value = true;
      String url = await uploadFile(File(gambarUrl.value.path));
      firestoreService.updateUserDetail(userID, namaController.text,
          emailController.text, noHpController.text, url);
      Get.snackbar(
        "Sukses",
        "Data User berhasil diubah",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      namaController.clear();
      emailController.clear();
      noHpController.clear();
      gambarUrl.value = XFile("");
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    getDetailUser();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    super.onClose();
  }
}
