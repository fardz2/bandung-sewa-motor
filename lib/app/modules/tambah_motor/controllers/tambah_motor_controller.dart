import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/firestore_service.dart';
import '../../../models/motor_model.dart';
import '../../../routes/app_pages.dart';

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
        Get.snackbar(
          "Peringatan",
          "Gambar motor belum dipilih",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        String url = await uploadFile(File(gambarMotor.value.path));
        firestoreService.addMotorbike(MotorModel(
          motorID: "",
          namaMotor: namaMotor.text,
          gambarUrl: url,
          merek: selectedMerek.value,
          cc: int.parse(cc.text),
          harga: int.parse(hargaMotor.text),
          jumlah: int.parse(jumlahMotor.text),
          status: int.parse(jumlahMotor.text) > 0 ? "Tersedia" : "Kosong",
        ));
        Get.snackbar(
          "Sukses",
          "Data motor berhasil ditambahkan",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        namaMotor.clear();
        jumlahMotor.clear();
        hargaMotor.clear();
        cc.clear();
        gambarMotor.value = XFile("");
        Get.offNamedUntil(
          Routes.LANDING_ADMIN,
          ModalRoute.withName(
            Routes.LANDING_ADMIN,
          ),
        );
      }
    }
  }

  void merekChanged(value) {
    selectedMerek.value = value.toString();
  }
}
