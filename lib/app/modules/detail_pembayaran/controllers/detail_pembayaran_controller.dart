import 'package:bandung_sewa_motor/app/helper/auth_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../helper/firestore_service.dart';

class DetailPembayaranController extends GetxController {
  var pesananID = "".obs;
  var metode = "".obs;
  var totalHarga = 0.obs;
  var ongkir = 0.obs;
  var totalPembayaran = 0.obs;
  var totalHari = 0.obs;
  final fotoKTP = "".obs;
  final fotoSIM = "".obs;
  final fotoHotel = "".obs;
  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  getDetailPesanan() {
    return firestoreService
        .getPesananByIdStream(pesananID.value)
        .listen((event) {
      totalHarga.value = event.rincianHarga['totalHarga'];
      ongkir.value = event.rincianHarga['ongkir'];
      totalPembayaran.value = totalHarga.value + ongkir.value;
      totalHari.value = DateFormat("dd MMMM yyyy", "id_ID")
              .parse(event.tanggalAkhir)
              .difference(
                  DateFormat("dd MMMM yyyy", "id_ID").parse(event.tanggalAwal))
              .inDays +
          1;
    });
  }

  getUserDataStream() {
    final userUID = authService.user.value?.uid;
    if (userUID != null) {
      return firestoreService.getUserStream(userUID).listen((event) {
        fotoKTP.value = event.ktpUrl;
        fotoHotel.value = event.hotelUrl;
        fotoSIM.value = event.simUrl;
      });
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    pesananID.value = Get.arguments['pesananID'];
    metode.value = Get.arguments['metode'];
    getDetailPesanan();
    getUserDataStream();
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
