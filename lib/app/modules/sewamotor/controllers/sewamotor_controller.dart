import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../helper/auth_service.dart';
import '../../../models/pesanan_model.dart';
import '../../../routes/app_pages.dart';

class SewamotorController extends GetxController {
  //TODO: Implement SewamotorController

  String userID = "";
  final count = 0.obs;
  final motorID = Get.arguments;
  final firestoreService = Get.put(FirestoreService());
  final authService = Get.put(AuthService());
  final opsi = "ambil".obs;
  final ongkir = 10000.obs;
  final lokasi_antar = TextEditingController();

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
        status: "Menunggu Konfirmasi",
      ));
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
        status: "Menunggu Konfirmasi",
      ));
    }
    Get.offNamed(
      Routes.METODE_BAYAR,
      arguments: newId,
    );
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
