import 'dart:io';

import 'package:bandung_sewa_motor/app/models/pembayaran_model.dart';
import 'package:bandung_sewa_motor/app/modules/detail_pembayaran/controllers/detail_pembayaran_controller.dart';
import 'package:bandung_sewa_motor/app/modules/metode_bayar/controllers/metode_bayar_controller.dart';
import 'package:bandung_sewa_motor/app/modules/sewamotor/controllers/sewamotor_controller.dart';
import 'package:bandung_sewa_motor/app/routes/app_pages.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bandung_sewa_motor/app/helper/auth_service.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/firestore_service.dart';

class BuktiPembayaranController extends GetxController {
  var pesananID = "".obs;
  var motorID = "".obs;

  var totalHarga = 0.obs;
  var ongkir = 0.obs;
  var totalPembayaran = 0.obs;
  var jumlah = 0.obs;

  final clipboardController = TextEditingController();

  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  getDetailPesanan() async {
    firestoreService.getPesananByIdStream(pesananID.value).listen((event) {
      totalHarga.value =
          event.rincianHarga['totalHarga'] - event.rincianHarga['ongkir'];
      ongkir.value = event.rincianHarga['ongkir'];
      motorID.value = event.motorID;
      totalPembayaran.value = event.rincianHarga['totalHarga'];
    });
  }

  getDetailMotor() async {
    firestoreService.getDetailMotor(motorID.value).listen((even) {
      jumlah.value = even.jumlah;
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
      await getDetailMotor();
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

      await firestoreService.updateMotorJumlah(motorID.value, jumlah.value - 1,
          jumlah.value - 1 == 0 ? "Tidak Tersedia" : "Tersedia");
      Get.snackbar(
        "Sukses",
        "Pesanan telah dibuat",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      buktiPembayaran.value = XFile("");
      Get.offNamedUntil(
        Routes.LANDING,
        ModalRoute.withName(Routes.LANDING),
      );
    }
  }

  @override
  void onInit() {
    pesananID.value = Get.arguments;

    getDetailPesanan();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<SewamotorController>();
    Get.delete<MetodeBayarController>();
    Get.delete<DetailPembayaranController>();
    super.onClose();
  }
}
