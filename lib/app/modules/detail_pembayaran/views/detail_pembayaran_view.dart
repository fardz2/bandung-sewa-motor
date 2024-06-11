import 'package:bandung_sewa_motor/app/widgets/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/format_harga.dart';
import '../../../routes/app_pages.dart';
import '../controllers/detail_pembayaran_controller.dart';

class DetailPembayaranView extends GetView<DetailPembayaranController> {
  const DetailPembayaranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54B175),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Obx(() {
          return Column(
            children: [
              const Text(
                "Detail Pembayaran",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
              Text(
                "No. Pesanan ${controller.pesananID.value}",
                style: const TextStyle(fontSize: 10, color: Colors.white),
              )
            ],
          );
        }),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rincian Harga",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff4F4F4F),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        customRow(
                          Text(
                            "Total Harga (${controller.totalHari.value} Hari)",
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            FormatHarga.formatRupiah(
                                controller.totalHarga.value),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 5),
                        customRow(
                          const Text(
                            "Biaya Antar Motor",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            FormatHarga.formatRupiah(controller.ongkir.value),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 5),
                        dottedLine(),
                        const SizedBox(height: 5),
                        customRow(
                            const Text("Total Pembayaran"),
                            Text(
                              FormatHarga.formatRupiah(
                                  controller.totalPembayaran.value),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff54B175),
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(height: 30),
                        customRow(
                          const Text("Metode Pembayaran"),
                          controller.metode.value == "Transfer BCA"
                              ? Image.asset('assets/icons/bca.png')
                              : const Text(
                                  "CASH",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text:
                        'Dengan menekan tombol di bawah ini, kamu telah menyetujui ',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(color: Colors.black),
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Syarat dan Ketentuan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff54B175),
                        ),
                      ),
                      TextSpan(text: ' dan '),
                      TextSpan(
                        text: 'Kebijakan Privasi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff54B175),
                        ),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ButtonCustom(
                    name: "Bayar Sekarang",
                    onPressed: () {
                      if (controller.fotoHotel.value.isEmpty ||
                          controller.fotoSIM.value.isEmpty ||
                          controller.fotoHotel.value.isEmpty) {
                        Get.snackbar(
                          "Persyaratan",
                          "Mohon dilengkapi terlebih dahulu persyaratannya",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        Get.toNamed(Routes.PERSYARATAN);
                      } else {
                        Get.toNamed(Routes.BUKTI_PEMBAYARAN,
                            arguments: controller.pesananID.value);
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customRow(Widget keterangan, Widget harga) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [keterangan, harga],
    );
  }

  Widget dottedLine() {
    return Row(
      children: List.generate(
        1000 ~/ 10,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : Colors.grey,
            height: 1,
          ),
        ),
      ),
    );
  }
}
