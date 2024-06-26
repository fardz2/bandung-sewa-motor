import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:bandung_sewa_motor/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../helper/auth_service.dart';
import '../../../models/pesanan_model.dart';

class SewamotorController extends GetxController {
  static SewamotorController get to => Get.find();

  String userID = "";
  final count = 0.obs;
  final motorID = Get.arguments;
  final firestoreService = Get.put(FirestoreService());
  final authService = Get.put(AuthService());
  final opsi = "ambil".obs;
  final ongkir = 10000.obs;
  final lokasi_antar = TextEditingController();
  final newIdPesanan = "".obs;

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

  void selectOption(String opsi) {
    this.opsi.value = opsi;
  }

  int totalHarga(int hargaMotor) {
    return opsi.value == "antar"
        ? (hargaMotor * totalDays.value) + ongkir.value
        : hargaMotor * totalDays.value;
  }

  getDetailMotor() {
    return firestoreService.getDetailMotor(motorID);
  }

  //datetime range picker
  final awalSewa =
      DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now()).obs;
  final akhirSewa = DateFormat('dd MMMM yyyy', 'id_ID')
      .format(DateTime.now().add(const Duration(days: 1)))
      .obs;
  final totalDays = 2.obs;
  getDateTimeRangePicker(BuildContext context) async {
    final DateTimeRange? range = await showDateRangePicker(
      saveText: "Simpan",
      cancelText: "Batal",
      context: context,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff54B175),
              onPrimary: Colors.white,
              secondary: Color(0xff54B175),
              onSecondary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)),
      ),
    );
    if (range != null) {
      awalSewa.value = DateFormat('dd MMMM yyyy', 'id_ID').format(range.start);
      akhirSewa.value = DateFormat('dd MMMM yyyy', 'id_ID').format(range.end);

      Duration totalRange = range.end.difference(range.start);
      totalDays.value = totalRange.inDays + 1;
    }
  }

  Future<void> buatPesanan(int totalHarga) async {
    final newId = await firestoreService.generateAutoId();
    newIdPesanan.value = newId;
    final Map<String, dynamic> rincianHarga = {
      "totalHarga": totalHarga,
      "ongkir": opsi.value == "antar" ? ongkir.value : 0,
    };
    if (opsi.value == "ambil") {
      await firestoreService.addPesanan(PesananModel(
        pesananID: newId,
        userID: userID,
        motorID: motorID,
        tanggalAwal: awalSewa.value,
        tanggalAkhir: akhirSewa.value,
        antar: false,
        rincianHarga: rincianHarga,
        tanggalPemesanan:
            DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now()),
        status: "Menunggu Konfirmasi",
        createdAt: Timestamp.now(),
      ));
      Get.offAndToNamed(
        Routes.METODE_BAYAR,
        arguments: newIdPesanan.value,
      );
    } else {
      if (lokasi_antar.text.isEmpty) {
        Get.back();
        Get.snackbar(
          "Peringatan",
          "Lokasi pengantaran harus diisi",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        await firestoreService.addPesanan(PesananModel(
          pesananID: newId,
          userID: userID,
          motorID: motorID,
          tanggalAwal: awalSewa.value,
          tanggalAkhir: akhirSewa.value,
          antar: true,
          rincianHarga: rincianHarga,
          lokasiAntar: lokasi_antar.text,
          tanggalPemesanan:
              DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now()),
          status: "Menunggu Konfirmasi",
          createdAt: Timestamp.now(),
        ));
        Get.offAndToNamed(
          Routes.METODE_BAYAR,
          arguments: newIdPesanan.value,
        );
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
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
