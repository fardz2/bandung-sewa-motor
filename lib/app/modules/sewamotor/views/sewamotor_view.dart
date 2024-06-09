import 'package:bandung_sewa_motor/app/helper/format_harga.dart';
import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:bandung_sewa_motor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sewamotor_controller.dart';

class SewamotorView extends GetView<SewamotorController> {
  const SewamotorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF54B175),
        title: const Text(
          'Sewa Motor',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/images/back.png'),
          color: Colors.white,
          onPressed: () {
            Get.back();
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
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  child: Image.network(
                                    snapshot.data!.gambarUrl,
                                    width: 40,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.namaMotor,
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
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Opsi Layanan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => Row(children: [
                              opsiLayanan(
                                  "assets/images/location.png",
                                  "assets/images/location_nonactive.png",
                                  "Ambil Ditempat",
                                  controller.opsi.value == "ambil",
                                  () => controller.selectOption("ambil")),
                              const SizedBox(width: 10),
                              opsiLayanan(
                                  "assets/images/antar_active.png",
                                  "assets/images/antar_nonactive.png",
                                  "Antar",
                                  controller.opsi.value == "antar",
                                  () => controller.selectOption("antar")),
                            ]),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/warning_icon.png",
                                width: 18,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Antar akan ada tambahan ongkos",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff4F4F4F),
                                ),
                              ),
                            ],
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
                          Obx(
                            () => controller.opsi.value == "antar"
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Lokasi Antar *",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      TextField(
                                          controller: controller.lokasi_antar,
                                          decoration: InputDecoration(
                                              hintText:
                                                  "Conton: Hotel Bandung Raya",
                                              hintStyle: const TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 16),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  borderSide: const BorderSide(
                                                      color: Colors
                                                          .transparent)))),
                                    ],
                                  )
                                : const SizedBox(height: 0),
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Durasi Sewa",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Ubah",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
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
                                    "23 Juni 2021(15.00)",
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
                                    "24 Juni 2021(15.00)",
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            "Rincian Bayar *",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Harga Sewa (2hari)",
                                    style: TextStyle(color: Color(0xff8A8A8E)),
                                  ),
                                  Obx(() => controller.opsi.value == "antar"
                                      ? const Text(
                                          "Ongkos Antar",
                                          style:
                                              TextStyle(color: Colors.orange),
                                        )
                                      : const SizedBox(
                                          height: 0,
                                        ))
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    FormatHarga.formatRupiah(
                                        snapshot.data!.harga),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Obx(() => controller.opsi.value == "antar"
                                      ? Text(
                                          FormatHarga.formatRupiah(
                                              controller.ongkir.value),
                                          style: const TextStyle(
                                              color: Colors.orange),
                                        )
                                      : const SizedBox(
                                          height: 0,
                                        ))
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
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
                            Obx(() => Text(
                                  FormatHarga.formatRupiah(
                                      controller.totalHarga(
                                          snapshot.data!.harga.toInt())),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )),
                            const Text(
                              'Per Hari',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed(Routes.METODE_BAYAR);
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
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget opsiLayanan(String image, String imageNonactive, String opsi,
      bool isSelected, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 78,
        width: 125,
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFF54B175) : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: isSelected
                  ? const BorderSide(color: Colors.transparent)
                  : const BorderSide(color: Color(0xFF54B175))),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image:
                    isSelected ? AssetImage(image) : AssetImage(imageNonactive),
              ),
              const SizedBox(height: 5),
              Text(
                opsi,
                style:
                    TextStyle(color: isSelected ? Colors.white : Colors.black),
              )
            ]),
      ),
    );
  }
}
