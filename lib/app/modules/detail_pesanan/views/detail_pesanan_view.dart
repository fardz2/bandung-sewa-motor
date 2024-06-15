import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:bandung_sewa_motor/app/models/pesanan_model.dart';
import 'package:bandung_sewa_motor/app/models/user_model.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_pesanan_controller.dart';

class DetailPesananView extends GetView<DetailPesananController> {
  const DetailPesananView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'Detail Pesanan',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'No. Pesanan: ${controller.pesananID}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff54B175),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<PesananModel>(
          stream: controller.getDetailPesanan(),
          builder: (context, pesananSnapshot) {
            if (!pesananSnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      pesananSnapshot.data!.status,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff54B175),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  StreamBuilder<MotorModel>(
                      stream: controller
                          .getMotorData(pesananSnapshot.data!.motorID),
                      builder: (context, motorSnapshot) {
                        if (!motorSnapshot.hasData) {
                          return const Center(
                            child: SizedBox(),
                          );
                        }
                        return Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xffEFEFF0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: motorSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? const SizedBox(
                                      height: 10,
                                    )
                                  : Center(
                                      child: Image.network(
                                        motorSnapshot.data!.gambarUrl,
                                        width: 40,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  motorSnapshot.data!.namaMotor,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Bandung Sewa motor",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff4F4F4F),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/check_icon.png",
                        width: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        pesananSnapshot.data!.antar
                            ? "Diantar"
                            : "Ambil Di Tempat",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff4F4F4F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/warning_icon.png",
                        width: 18,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Tidak bisa reschedule",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff4F4F4F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Data Penyewa",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  StreamBuilder<UserModel>(
                      stream:
                          controller.getUserData(pesananSnapshot.data!.userID),
                      builder: (context, userSnapshot) {
                        if (!userSnapshot.hasData) {
                          return const Center(
                            child: SizedBox(),
                          );
                        }
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Text(
                            "${userSnapshot.data!.name} (${userSnapshot.data!.phone})",
                            style: const TextStyle(color: Color(0xff4F4F4F)),
                          ),
                        );
                      }),
                  const SizedBox(height: 16),
                  Text(
                    pesananSnapshot.data!.antar
                        ? "Lokasi Pengantaran *"
                        : "Lokasi Pengambilan *",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pesananSnapshot.data!.antar
                        ? pesananSnapshot.data!.lokasiAntar.toString()
                        : "Jl. Melati II No. 30 Blok 8 Perumahan Sadang Serang Kel. Sekeloa Kec. Coblong",
                    style: const TextStyle(color: Color(0xff4F4F4F)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Lokasi Pengembalian *",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Jl. Melati II No. 30 Blok 8 Perumahan Sadang Serang Kel. Sekeloa Kec. Coblong",
                    style: TextStyle(color: Color(0xff4F4F4F)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Durasi Sewa (${DateFormat("dd MMMM yyyy", "id_ID").parse(pesananSnapshot.data!.tanggalAkhir).difference(DateFormat("dd MMMM yyyy", "id_ID").parse(pesananSnapshot.data!.tanggalAwal)).inDays + 1} Hari)",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Pengambilan :",
                            style: TextStyle(color: Color(0xff8A8A8E)),
                          ),
                          Text(
                            pesananSnapshot.data!.tanggalAwal,
                          ),
                        ],
                      ),
                      Container(
                        height: 24,
                        width: 1,
                        color: const Color(0xff4F4F4F),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Pengembalian :",
                            style: TextStyle(color: Color(0xff8A8A8E)),
                          ),
                          Text(
                            pesananSnapshot.data!.tanggalAkhir,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 52),
                ],
              ),
            );
          }),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        height: 100,
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/icons/warning_icon.png",
                  width: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Untuk membatalkan pesanan bisa\n hubungi kantor sewa",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff4F4F4F),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff54B175),
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Hubungi Kantor Sewa",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
