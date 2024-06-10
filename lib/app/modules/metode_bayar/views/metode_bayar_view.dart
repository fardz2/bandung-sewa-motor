import 'package:bandung_sewa_motor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helper/format_harga.dart';
import '../../../models/motor_model.dart';
import '../../../models/pesanan_model.dart';
import '../../../widgets/dotted_line.dart';
import '../controllers/metode_bayar_controller.dart';

class MetodeBayarView extends GetView<MetodeBayarController> {
  const MetodeBayarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        title: const Text(
          'Metode Pembayaran',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff54B175),
      ),
      body: StreamBuilder<PesananModel>(
          stream: controller.getDetailPesanan(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No Pesanan found'));
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder<MotorModel>(
                            stream:
                                controller.getMotorById(snapshot.data!.motorID),
                            builder: (context, snapshotMotor) {
                              if (snapshotMotor.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshotMotor.hasError) {
                                return Center(
                                    child:
                                        Text('Error: ${snapshotMotor.error}'));
                              } else if (!snapshotMotor.hasData) {
                                return const Center(
                                    child: Text('No Motor found'));
                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshotMotor.data!.merek} ${snapshotMotor.data!.namaMotor}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff828282),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data!.tanggalAwal,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff828282),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Icon(
                                          Icons.arrow_right_alt_rounded,
                                          color: Color(0xff828282),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          snapshot.data!.tanggalAkhir,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff828282),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            }),
                        Text(
                          snapshot.data!.antar ? "Diantar" : "Ambil di tempat",
                          style: const TextStyle(
                            color: Color(0xff54B175),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const DottedLine(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "No. Pesanan",
                        ),
                        Text(
                          snapshot.data!.pesananID,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const DottedLine(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Pembayaran",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          FormatHarga.formatRupiah(
                              snapshot.data!.rincianHarga['totalHarga']),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff54B175),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PEMBAYARAN, arguments: {
                          "pesananID": snapshot.data!.pesananID,
                          "metode": "CASH",
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Cash",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff4F4F4F),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Color(0xff4F4F4F),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Transfer",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_PEMBAYARAN,
                                    arguments: {
                                      "pesananID": snapshot.data!.pesananID,
                                      "metode": "Transfer BCA",
                                    });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/bca.png",
                                    width: 50,
                                  ),
                                  const Text(
                                    "Bank BCA",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff4F4F4F),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xff4F4F4F),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
