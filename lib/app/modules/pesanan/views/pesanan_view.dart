import 'package:bandung_sewa_motor/app/helper/format_harga.dart';
import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:bandung_sewa_motor/app/models/pesanan_model.dart';
import 'package:bandung_sewa_motor/app/widgets/card_pesanan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/pesanan_controller.dart';

class PesananView extends GetView<PesananController> {
  const PesananView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Pesanan',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
            final combinedList = snapshot.data as List<Map<String, dynamic>>;
            combinedList.sort((a, b) => (b['pesanan'] as PesananModel)
                .pesananID
                .compareTo((a['pesanan'] as PesananModel).pesananID));
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              itemCount: combinedList.length,
              itemBuilder: (context, index) {
                final pesanan = combinedList[index]['pesanan'] as PesananModel;
                final motor = combinedList[index]['motor'] as MotorModel;
                return CardPesanan(
                  noPesanan: pesanan.pesananID.toString(),
                  tanggal:
                      pesanan.tanggalPemesanan, // Format this date properly
                  namaMotor: motor.namaMotor,
                  lokasi: "Sewa Motor Lempuyangan",
                  harga: FormatHarga.formatRupiah(
                      pesanan.rincianHarga["totalHarga"]),
                  status: pesanan.status,
                  onPressed: () {
                    Get.toNamed(Routes.DETAIL_PESANAN,
                        arguments: pesanan.pesananID.toString());
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
