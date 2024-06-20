import 'package:bandung_sewa_motor/app/helper/format_harga.dart';
import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:bandung_sewa_motor/app/routes/app_pages.dart';
import 'package:bandung_sewa_motor/app/widgets/feature_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/detailmotoradmin_controller.dart';

class DetailmotoradminView extends GetView<DetailmotoradminController> {
  const DetailmotoradminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF54B175),
        title: const Text(
          'Detail Motor',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/images/back.png'),
          color: Colors.white,
          onPressed: () {
            Get.offNamed(Routes.LANDING_ADMIN);
          },
        ),
      ),
      body: StreamBuilder<MotorModel>(
          stream: controller.getDetailMotor(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: PopupMenuButton<String>(
                          color: const Color(0xFF54B175),
                          onSelected: (String result) {
                            // result == "Hapus"
                            //     ? controller.hapusMotor(snapshot.data!.motorID)
                            //     : "";
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'Hapus',
                              onTap: () {
                                Get.dialog(
                                  AlertDialog(
                                    title: Text(snapshot.data!.namaMotor),
                                    content: Text(
                                        'Yakin ingin menghapus motor ${snapshot.data!.namaMotor}?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('CANCEL'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.hapusMotor(
                                              snapshot.data!.motorID,
                                              snapshot.data!.gambarUrl);
                                        },
                                        child: const Text(
                                          'HAPUS',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text(
                                'Hapus',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            PopupMenuItem<String>(
                              onTap: () {
                                Get.toNamed(
                                  Routes.EDIT_MOTOR,
                                  arguments: snapshot.data!.motorID,
                                );
                              },
                              value: 'Edit',
                              child: const Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Image
                      SizedBox(
                        height: 300,
                        child: Image.network(
                          snapshot.data!.gambarUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Title
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 18),
                            Text(
                              snapshot.data!.namaMotor,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              snapshot.data!.merek,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black26),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${snapshot.data!.cc.toString()} cc",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black26),
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              'Fitur',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      // Feature Card 1
                                      FeatureCard(
                                        imagePath: 'assets/images/helm.png',
                                        text: '2 Helm',
                                      ),
                                      SizedBox(width: 16),
                                      // Feature Card 2
                                      FeatureCard(
                                        imagePath: 'assets/images/jas.png',
                                        text: '2 Jas Hujan',
                                      ),
                                      SizedBox(width: 16),
                                      // Feature Card 3
                                      FeatureCard(
                                        imagePath: 'assets/images/driver.png',
                                        text: 'Antar motor',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white, // Set background color to white
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FormatHarga.formatRupiah(snapshot.data!.harga),
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Per Hari',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     Get.toNamed(Routes.METODE_BAYAR);
                        //   },
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all(
                        //         const Color.fromARGB(255, 0x54, 0xB1, 0x75)),
                        //     shape: MaterialStateProperty.all(
                        //       RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(8),
                        //       ),
                        //     ),
                        //   ),
                        //   child: const Text(
                        //     'Pesan Sekarang',
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
