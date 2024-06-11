import 'dart:io';

import 'package:bandung_sewa_motor/app/models/pembayaran_model.dart';
import 'package:bandung_sewa_motor/app/models/pesanan_model.dart';
import 'package:bandung_sewa_motor/app/routes/app_pages.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bandung_sewa_motor/app/helper/auth_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/firestore_service.dart';

class BuktiPembayaranController extends GetxController {
  //TODO: Implement BuktiPembayaranController

  var pesananID = "".obs;
  // var metode = "".obs;
  var totalHarga = 0.obs;
  var ongkir = 0.obs;
  var totalPembayaran = 0.obs;

  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  getDetailPesanan() {
    firestoreService.getPesananByIdStream(pesananID.value).listen((event) {
      totalHarga.value = event.rincianHarga['totalHarga'];
      ongkir.value = event.rincianHarga['ongkir'];
      totalPembayaran.value = totalHarga.value + ongkir.value;
    });
  }

  final buktiPembayaran = XFile("").obs;
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
      buktiPembayaran.value = pickedFile;
    }
  }

  // untuk mengupload gambar ke firebase storage
  Future<String> uploadFile(File image) async {
    final storageReference =
        FirebaseStorage.instance.ref().child('BuktiPembayaran/${image.path}');
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
    if (buktiPembayaran.value.path == "") {
      Get.snackbar(
        "Peringatan",
        "Gambar pembayaran belum dipilih",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      String url = await uploadFile(File(buktiPembayaran.value.path));

      String pembayaranID = await firestoreService.addPembayaran(
          PembayaranModel(
              pembayaranID: "",
              rentalID: pesananID.value,
              userID: authService.user.value!.uid,
              totalHarga: totalPembayaran.value,
              buktiPembayaran: url,
              metode: "transfer",
              status: "pending"));
      await firestoreService.updatePesananPembayaran(
        pesananID.value,
        pembayaranID,
      );
      Get.snackbar(
        "Sukses",
        "Data motor berhasil ditambahkan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      buktiPembayaran.value = XFile("");
      Get.offNamed(Routes.LANDING);
    }
  }

  @override
  void onInit() {
    pesananID.value = Get.arguments;
    print(pesananID.value);
    // metode.value = Get.arguments['metode'];
    getDetailPesanan();

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
