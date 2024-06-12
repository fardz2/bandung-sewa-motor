import 'dart:ffi';

import 'package:bandung_sewa_motor/app/helper/auth_service.dart';
import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:get/get.dart';

class DetailPesananController extends GetxController {
  //TODO: Implement DetailPesananController

  final pesananID = Get.arguments;
  final no_pesanan = "".obs;
  final nama_motor = "".obs;
  final gambar_motor = "".obs;
  final id_pelanggan = "".obs;
  final id_motor = "".obs;
  final nama_pelanggan = "".obs;
  final lokasi_antar = "".obs;
  final tanggal_pengambilan = "".obs;
  final tanggal_pengembalian = "".obs;
  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  getDetailPesanan() async {
    firestoreService.getPesananByIdStream(pesananID).listen((even) {
      lokasi_antar.value = even.lokasiAntar.toString();

      tanggal_pengambilan.value = even.tanggalAwal.toString();
      tanggal_pengembalian.value = even.tanggalAkhir.toString();
      id_pelanggan.value = even.userID;
      firestoreService.getUserStream(id_pelanggan.value).listen((even) {
        nama_pelanggan.value = even.name;
      });
      id_motor.value = even.motorID;
      firestoreService.getDetailMotor(id_motor.value).listen((even) {
        nama_motor.value = even.namaMotor;
        gambar_motor.value = even.gambarUrl;
      });
    });
  }

  @override
  void onInit() {
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
