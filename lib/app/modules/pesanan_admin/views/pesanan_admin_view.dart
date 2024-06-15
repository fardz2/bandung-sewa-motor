import 'package:bandung_sewa_motor/app/helper/format_harga.dart';
import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:bandung_sewa_motor/app/models/pesanan_model.dart';
import 'package:bandung_sewa_motor/app/widgets/card_pesanan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<PesananModel>>(
        stream: controller.getAllPesanan(),
        builder: (context, pesananSnapshot) {
          if (pesananSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (pesananSnapshot.hasError) {
            return Center(child: Text('Error: ${pesananSnapshot.error}'));
          } else if (!pesananSnapshot.hasData ||
              pesananSnapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              itemCount: pesananSnapshot.data?.length,
              itemBuilder: (context, index) {
                return StreamBuilder<MotorModel>(
                    stream: controller
                        .getDetailMotor(pesananSnapshot.data![index].motorID),
                    builder: (context, motorSnapshot) {
                      if (!motorSnapshot.hasData) {
                        return const SizedBox();
                      }
                      return CardPesanan(
                        noPesanan: pesananSnapshot.data![index].pesananID,
                        tanggal: pesananSnapshot.data![index]
                            .tanggalPemesanan, // Format this date properly
                        namaMotor:
                            "${motorSnapshot.data!.merek} ${motorSnapshot.data!.namaMotor}",
                        lokasi:
                            "${DateFormat("dd MMMM yyyy", "id_ID").parse(pesananSnapshot.data![index].tanggalAkhir).difference(DateFormat("dd MMMM yyyy", "id_ID").parse(pesananSnapshot.data![index].tanggalAwal)).inDays + 1} Hari - ${pesananSnapshot.data![index].antar ? 'Diantar' : 'Ambil Di Tempat'}",
                        harga: FormatHarga.formatRupiah(pesananSnapshot
                            .data?[index].rincianHarga["totalHarga"]),
                        status: pesananSnapshot.data![index].status,
                        onPressed: () {
                          Get.toNamed(Routes.KONFIRMASI_PESANAN,
                              arguments:
                                  pesananSnapshot.data![index].pesananID);
                        },
                      );
                    });
              },
            );
          }
        },
      ),
    );
  }
}
