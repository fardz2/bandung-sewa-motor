import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bukti_pembayaran_controller.dart';

class BuktiPembayaranView extends GetView<BuktiPembayaranController> {
  const BuktiPembayaranView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'Upload Bukti Bayar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'No. Pesanan: SMJ000233',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff54B175),
        leading: IconButton(
          onPressed: () {},
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
                      "Dadang Suharja",
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.copy_rounded,
                      color: Color(0xff54B175),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jumlah Total Bayar",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff828282),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Rp. 120.123",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(
                      Icons.copy_rounded,
                      size: 18,
                      color: Color(0xff828282),
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: const Color(0xff828282),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ElevatedButton(
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
