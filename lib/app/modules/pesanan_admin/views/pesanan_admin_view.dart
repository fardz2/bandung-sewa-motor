import 'package:bandung_sewa_motor/app/modules/pesanan_admin/controllers/pesanan_admin_controller.dart';
import 'package:bandung_sewa_motor/app/widgets/card_pesanan.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class PesananAdminView extends GetView<PesananAdminController> {
  const PesananAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesanan',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0x54, 0xB1, 0x75),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        itemCount: 1,
        itemBuilder: (context, index) {
          return CardPesanan(
              noPesanan: "SMJ00233",
              tanggal: "Rab, 23 Jun 2021",
              namaMotor: "Honda Beat 2018",
              lokasi: "Sewa Motor Lempuyangan",
              harga: "120.000",
              onPressed: () {
                Get.toNamed(Routes.KONFIRMASI_PESANAN);
              });
        },
      ),
    );
  }
}
