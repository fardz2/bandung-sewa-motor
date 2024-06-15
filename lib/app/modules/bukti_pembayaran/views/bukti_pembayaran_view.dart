import 'dart:io';

import 'package:bandung_sewa_motor/app/helper/format_harga.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controllers/bukti_pembayaran_controller.dart';

class BuktiPembayaranView extends GetView<BuktiPembayaranController> {
  const BuktiPembayaranView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'Upload Bukti Bayar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'No. Pesanan: ${controller.pesananID.value}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Pemilik Rekening",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff828282),
                      ),
                    ),
                    Text(
                      "Salman Ananda",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4F4F4F),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/icons/bca.png",
                  width: 72,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xffF3F5FF),
                border: Border.all(
                  color: const Color(0xff54B175),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nomor Rekening",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff54B175),
                        ),
                      ),
                      Text(
                        "8648499124",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff54B175),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: "8648499124"))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.fromLTRB(24, 0, 24, 400),
                            content: Text("Nomor rekening berhasil disalin"),
                          ),
                        );
                      });
                    },
                    icon: const Icon(
                      Icons.copy_rounded,
                      color: Color(0xff54B175),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jumlah Total Bayar",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff828282),
                  ),
                ),
                Row(
                  children: [
                    Obx(
                      () => Text(
                        FormatHarga.formatRupiah(
                            controller.totalPembayaran.value),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                                text: controller.totalPembayaran.value
                                    .toString()))
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.fromLTRB(24, 0, 24, 350),
                              content: Text("Total bayar berhasil disalin"),
                            ),
                          );
                        });
                      },
                      child: const Icon(
                        Icons.copy_rounded,
                        size: 18,
                        color: Color(0xff828282),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Konfirmasi Pembayaran",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Bantu kami mengkonfirmasi pembayaran kamu dengan mengetuk tombol “Sudah Bayar” di bawah.",
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 16),
            const Text(
              "Upload Bukti Pembayaran",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return GestureDetector(
                onTap: () {
                  controller.getImage(true);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      color: const Color(0xff828282),
                      borderRadius: BorderRadius.circular(10)),
                  child: controller.buktiPembayaran.value.path != ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(controller.buktiPembayaran.value.path),
                          ),
                        )
                      : const Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.white,
                        ),
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ElevatedButton(
          onPressed: controller.submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff54B175),
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Text(
            "Sudah Bayar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
