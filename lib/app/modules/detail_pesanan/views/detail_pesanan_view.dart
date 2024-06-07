import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_pesanan_controller.dart';

class DetailPesananView extends GetView<DetailPesananController> {
  const DetailPesananView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'Detail Pesanan',
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
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Menunggu Konfirmasi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff54B175),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xffEFEFF0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/beat.png",
                      width: 40,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Honda Beat",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Bandung Sewa motor",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff4F4F4F),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Image.asset(
                  "assets/icons/check_icon.png",
                  width: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Bisa Refund",
                  style: TextStyle(
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: const Text(
                "Salman Ananda ( 08123456789 )",
                style: TextStyle(color: Color(0xff4F4F4F)),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Lokasi Pengambilan *",
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
            const Text(
              "Durasi Sewa *",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pengambilan :",
                      style: TextStyle(color: Color(0xff8A8A8E)),
                    ),
                    Text(
                      "12 Juni 2024",
                    ),
                  ],
                ),
                Container(
                  height: 24,
                  width: 1,
                  color: const Color(0xff4F4F4F),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pengembalian :",
                      style: TextStyle(color: Color(0xff8A8A8E)),
                    ),
                    Text(
                      "13 Juni 2024",
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 52),
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
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xff8A8A8E)),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Batalkan Pesanan",
                style: TextStyle(
                  color: Color(0xff8A8A8E),
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
