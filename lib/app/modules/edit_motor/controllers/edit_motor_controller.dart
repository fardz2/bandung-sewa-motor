import 'dart:io';

import 'package:bandung_sewa_motor/app/modules/detailmotoradmin/controllers/detailmotoradmin_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/firestore_service.dart';
import '../../../models/motor_model.dart';
import '../../../routes/app_pages.dart';

class EditMotorController extends GetxController {
  List<String> merekOptions = ['Honda', 'Yamaha', 'Suzuki', 'Kawasaki'];
  Rx<String> selectedMerek = 'Honda'.obs;
  void merekChanged(value) {
    selectedMerek.value = value.toString();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final namaMotor = TextEditingController();
  final jumlahMotor = TextEditingController();
  final hargaMotor = TextEditingController();
  final cc = TextEditingController();
  final gambarMotorUrl = "".obs;
  final isLoading = false.obs;

  final motorID = Get.arguments;

  getDetailImage() {
    return firestoreService.getDetailMotor(motorID);
  }

  getDetailMotor() async {
    try {
      await firestoreService.getDetailMotorFuture(motorID).then((value) {
        namaMotor.text = value.namaMotor;
        jumlahMotor.text = value.jumlah.toString();
        hargaMotor.text = value.harga.toString();
        cc.text = value.cc.toString();
        selectedMerek.value = value.merek;
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    getDetailMotor();
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
    Get.delete<DetailmotoradminController>();
    super.onClose();
  }

  final gambarMotor = XFile("").obs;
  // untuk mengambil gambar
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
      gambarMotor.value = pickedFile;
    }
  }

  // untuk mengupload gambar ke firebase storage
  Future<String> uploadFile(File image) async {
    final storageReference =
        FirebaseStorage.instance.ref().child('Motor/${image.path}');
    await storageReference.putFile(image);
    String returnURL = "";
    await storageReference.getDownloadURL().then(
      (fileURL) {
        returnURL = fileURL;
      },
    );
    return returnURL;
  }

  final firestoreService = Get.put(FirestoreService());

  void submit() async {
    if (formKey.currentState!.validate()) {
      if (gambarMotor.value.path == "") {
        isLoading.value = true;
        firestoreService.updateMotor(MotorModel(
          motorID: motorID,
          merek: selectedMerek.value,
          namaMotor: namaMotor.text,
          jumlah: int.parse(jumlahMotor.text),
          harga: int.parse(hargaMotor.text),
          cc: int.parse(cc.text),
          gambarUrl: gambarMotorUrl.toString(),
          status: jumlahMotor.text == "0" ? "Tidak Tersedia" : "Tersedia",
        ));
        Get.snackbar(
          "Sukses",
          "Data motor berhasil diubah",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        namaMotor.clear();
        jumlahMotor.clear();
        hargaMotor.clear();
        cc.clear();
      } else {
        isLoading.value = true;
        String url = await uploadFile(File(gambarMotor.value.path));
        firestoreService.updateMotor(MotorModel(
          motorID: motorID,
          merek: selectedMerek.value,
          namaMotor: namaMotor.text,
          jumlah: int.parse(jumlahMotor.text),
          harga: int.parse(hargaMotor.text),
          cc: int.parse(cc.text),
          gambarUrl: url,
          status: jumlahMotor.text == "0" ? "Tidak Tersedia" : "Tersedia",
        ));
        Get.snackbar(
          "Sukses",
          "Data motor berhasil diubah",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        namaMotor.clear();
        jumlahMotor.clear();
        hargaMotor.clear();
        cc.clear();
        gambarMotor.value = XFile("");
      }
      isLoading.value = false;
      Get.offNamedUntil(
        Routes.LANDING_ADMIN,
        ModalRoute.withName(
          Routes.LANDING_ADMIN,
        ),
      );
    }
  }
}
