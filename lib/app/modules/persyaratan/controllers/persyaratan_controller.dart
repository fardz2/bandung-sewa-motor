import 'dart:io';

import 'package:bandung_sewa_motor/app/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/auth_service.dart';
import '../../../helper/firestore_service.dart';

class PersyaratanController extends GetxController {
  static PersyaratanController get to => Get.find<PersyaratanController>();

  String userID = "";
  final fotoKTPAwal = "".obs;
  final fotoSIMAwal = "".obs;
  final fotoHotelAwal = "".obs;

  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  getUserData() async {
    final userUID = authService.user.value?.uid;
    if (userUID != null) {
      await firestoreService.getUser(userUID).then(
        (value) {
          userID = value!.userID;
        },
      );
    } else {
      return null;
    }
  }

  getUserDataStream() {
    final userUID = authService.user.value?.uid;
    if (userUID != null) {
      return firestoreService.getUserStream(userUID);
    } else {
      return null;
    }
  }

  final fotoKTPUrl = XFile("").obs;
  final fotoSIMUrl = XFile("").obs;
  final fotoHotelUrl = XFile("").obs;

  Future getImageKTP(bool gallery) async {
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
      fotoKTPUrl.value = pickedFile;
    }
  }

  Future getImageSIM(bool gallery) async {
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
      fotoSIMUrl.value = pickedFile;
    }
  }

  Future getImageHotel(bool gallery) async {
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
      fotoHotelUrl.value = pickedFile;
    }
  }

  Future<String> uploadFile(File image) async {
    final storageReference =
        FirebaseStorage.instance.ref().child('User/$userID/${image.path}');
    await storageReference.putFile(image);
    String returnURL = "";
    await storageReference.getDownloadURL().then(
      (fileURL) {
        returnURL = fileURL;
      },
    );
    return returnURL;
  }

  void submit() async {
    if (fotoHotelUrl.value.path == "" &&
        fotoKTPUrl.value.path == "" &&
        fotoSIMUrl.value.path == "" &&
        fotoKTPAwal.isNotEmpty &&
        fotoSIMAwal.isNotEmpty &&
        fotoHotelAwal.isNotEmpty) {
      firestoreService.updateUserUrl(
        UserModel(
          userID: userID,
          name: "",
          email: "",
          phone: "",
          hotelUrl: fotoHotelAwal.value,
          ktpUrl: fotoKTPAwal.value,
          simUrl: fotoSIMAwal.value,
        ),
      );
      Get.snackbar(
        "Tidak Berubah",
        "Data persyaratan tidak berubah",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      Get.back();
    } else if (fotoHotelUrl.value.path == "" &&
        fotoKTPUrl.value.path == "" &&
        fotoSIMUrl.value.path == "") {
      Get.snackbar(
        "Gagal",
        "Foto belum dipilih",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (fotoHotelUrl.value.path.isNotEmpty &&
        fotoKTPUrl.value.path.isNotEmpty &&
        fotoSIMUrl.value.path == "") {
      String urlHotel = await uploadFile(File(fotoHotelUrl.value.path));
      String urlKTP = await uploadFile(File(fotoKTPUrl.value.path));
      firestoreService.updateUserUrl(
        UserModel(
          userID: userID,
          name: "",
          email: "",
          phone: "",
          hotelUrl: urlHotel,
          ktpUrl: urlKTP,
          simUrl: fotoSIMAwal.value,
        ),
      );
      Get.back();
      Get.snackbar(
        "Sukses",
        "Foto Hotel dan KTP berhasil diupdate",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else if (fotoHotelUrl.value.path.isNotEmpty &&
        fotoKTPUrl.value.path == "" &&
        fotoSIMUrl.value.path.isNotEmpty) {
      String urlHotel = await uploadFile(File(fotoHotelUrl.value.path));
      String urlSIM = await uploadFile(File(fotoSIMUrl.value.path));
      firestoreService.updateUserUrl(
        UserModel(
          userID: userID,
          name: "",
          email: "",
          phone: "",
          hotelUrl: urlHotel,
          ktpUrl: fotoKTPAwal.value,
          simUrl: urlSIM,
        ),
      );
      Get.back();
      Get.snackbar(
        "Sukses",
        "Foto Hotel dan SIM berhasil diupdate",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else if (fotoHotelUrl.value.path == "" &&
        fotoKTPUrl.value.path.isNotEmpty &&
        fotoSIMUrl.value.path.isNotEmpty) {
      String urlSIM = await uploadFile(File(fotoSIMUrl.value.path));
      String urlKTP = await uploadFile(File(fotoKTPUrl.value.path));
      firestoreService.updateUserUrl(
        UserModel(
          userID: userID,
          name: "",
          email: "",
          phone: "",
          hotelUrl: fotoHotelAwal.value,
          ktpUrl: urlKTP,
          simUrl: urlSIM,
        ),
      );
      Get.back();
      Get.snackbar(
        "Sukses",
        "Foto SIM dan KTP berhasil diupdate",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else if (fotoKTPUrl.value.path.isNotEmpty &&
            fotoSIMUrl.value.path == "" ||
        fotoHotelUrl.value.path == "") {
      String urlKTP = await uploadFile(File(fotoKTPUrl.value.path));
      firestoreService.updateUserUrl(
        UserModel(
          userID: userID,
          name: "",
          email: "",
          phone: "",
          hotelUrl: fotoHotelAwal.value,
          ktpUrl: urlKTP,
          simUrl: fotoSIMAwal.value,
        ),
      );
      Get.back();
      Get.snackbar(
        "Sukses",
        "Foto KTP berhasil diupdate",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else if (fotoSIMUrl.value.path.isNotEmpty &&
            fotoKTPUrl.value.path == "" ||
        fotoHotelUrl.value.path == "") {
      String urlSIM = await uploadFile(File(fotoSIMUrl.value.path));
      firestoreService.updateUserUrl(
        UserModel(
          userID: userID,
          name: "",
          email: "",
          phone: "",
          hotelUrl: fotoHotelAwal.value,
          ktpUrl: fotoKTPAwal.value,
          simUrl: urlSIM,
        ),
      );
      Get.back();
      Get.snackbar(
        "Sukses",
        "Foto SIM berhasil diupdate",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else if (fotoHotelUrl.value.path.isNotEmpty &&
            fotoKTPUrl.value.path == "" ||
        fotoSIMUrl.value.path == "") {
      String urlHotel = await uploadFile(File(fotoHotelUrl.value.path));
      firestoreService.updateUserUrl(
        UserModel(
          userID: userID,
          name: "",
          email: "",
          phone: "",
          hotelUrl: urlHotel,
          ktpUrl: fotoKTPAwal.value,
          simUrl: fotoSIMAwal.value,
        ),
      );
      Get.back();
      Get.snackbar(
        "Sukses",
        "Foto Hotel berhasil diupdate",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      String urlKTP = await uploadFile(File(fotoKTPUrl.value.path));
      String urlSIM = await uploadFile(File(fotoSIMUrl.value.path));
      String urlHotel = await uploadFile(File(fotoHotelUrl.value.path));
      firestoreService.updateUserUrl(
        UserModel(
          userID: userID,
          name: "",
          email: "",
          phone: "",
          hotelUrl: urlHotel,
          ktpUrl: urlKTP,
          simUrl: urlSIM,
        ),
      );
      Get.back();
      Get.snackbar(
        "Sukses",
        "Data persyaratan berhasil disimpan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    getUserData();
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
