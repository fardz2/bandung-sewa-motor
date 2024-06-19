import 'package:bandung_sewa_motor/app/helper/format_harga.dart';
import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:bandung_sewa_motor/app/widgets/feature_card.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/detail_motor_controller.dart';

class DetailMotorView extends GetView<DetailMotorController> {
  const DetailMotorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        title: const Text(
          'Detail',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0x54, 0xB1, 0x75),
        centerTitle: true,
      ),
      body: StreamBuilder<MotorModel>(
          stream: controller.getDetailMotor(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
            );
          }),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: StreamBuilder<MotorModel>(
            stream: controller.getDetailMotor(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: SizedBox(),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FormatHarga.formatRupiah(snapshot.data!.harga),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Per Hari',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAndToNamed(Routes.SEWAMOTOR,
                          arguments: snapshot.data?.motorID);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 0x54, 0xB1, 0x75)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Pesan Sekarang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
