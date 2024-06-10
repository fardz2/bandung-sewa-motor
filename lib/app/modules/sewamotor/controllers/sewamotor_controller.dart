import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SewamotorController extends GetxController {
  //TODO: Implement SewamotorController

  final count = 0.obs;
  final motorID = Get.arguments;
  final firestoreService = Get.put(FirestoreService());
  final opsi = "ambil".obs;
  final ongkir = 10000.obs;
  final lokasi_antar = TextEditingController();
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
  final totalDays = 1.obs;
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
}
