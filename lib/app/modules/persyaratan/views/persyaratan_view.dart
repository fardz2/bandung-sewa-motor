import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../widgets/button_custom.dart';
import '../controllers/persyaratan_controller.dart';

class PersyaratanView extends GetView<PersyaratanController> {
  const PersyaratanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF54B175),
        title: const Text(
          'Persyaratan',
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
      body: SingleChildScrollView(
        child: StreamBuilder<UserModel>(
            stream: controller.getUserDataStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                controller.fotoKTPAwal.value = snapshot.data!.ktpUrl;
                controller.fotoSIMAwal.value = snapshot.data!.simUrl;
                controller.fotoHotelAwal.value = snapshot.data!.hotelUrl;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Masukan Foto KTP",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(() {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff828282),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: controller.fotoKTPUrl.value.path != ""
                                      ? GestureDetector(
                                          onTap: () async {
                                            await controller.getImageKTP(true);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              File(controller
                                                  .fotoKTPUrl.value.path),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            await controller.getImageKTP(true);
                                          },
                                          child: snapshot.data!.ktpUrl != ""
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    snapshot.data!.ktpUrl,
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Masukan Foto SIM C",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(() {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff828282),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: controller.fotoSIMUrl.value.path != ""
                                      ? GestureDetector(
                                          onTap: () async {
                                            await controller.getImageSIM(true);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              File(controller
                                                  .fotoSIMUrl.value.path),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            await controller.getImageSIM(true);
                                          },
                                          child: snapshot.data!.simUrl != ""
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    snapshot.data!.simUrl,
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
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Masukan Bukti Reservasi Hotel",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(() {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff828282),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: controller.fotoHotelUrl.value.path !=
                                          ""
                                      ? GestureDetector(
                                          onTap: () async {
                                            await controller
                                                .getImageHotel(true);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              File(controller
                                                  .fotoHotelUrl.value.path),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            await controller
                                                .getImageHotel(true);
                                          },
                                          child: snapshot.data!.hotelUrl != ""
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    snapshot.data!.hotelUrl,
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
                        SizedBox(height: 20),
                        Center(
                            child: ButtonCustom(
                          name: 'Simpan',
                          onPressed: () {
                            controller.submit();
                          },
                        )),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
