import 'package:bandung_sewa_motor/app/helper/format_harga.dart';
import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:bandung_sewa_motor/app/models/pesanan_model.dart';
import 'package:bandung_sewa_motor/app/widgets/card_pesanan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/pesanan_admin_controller.dart';

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
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: controller.fetchPesananWithDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data'));
          } else {
            final combinedList = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              itemCount: combinedList.length,
              itemBuilder: (context, index) {
                final pesanan = combinedList[index]['pesanan'] as PesananModel;
                final motor = combinedList[index]['motor'] as MotorModel;
                return CardPesanan(
                  noPesanan: pesanan.pesananID.toString(),
                  tanggal: "Rab, 23 Jun 2021",
                  namaMotor: motor.namaMotor,
                  lokasi: "Sewa Motor Lempuyangan",
                  harga: FormatHarga.formatRupiah(
                      pesanan.rincianHarga["totalHarga"]),
                  onPressed: () {
                    Get.toNamed(Routes.KONFIRMASI_PESANAN);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
