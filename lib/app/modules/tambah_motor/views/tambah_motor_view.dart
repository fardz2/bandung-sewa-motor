import 'dart:io';

import 'package:bandung_sewa_motor/app/helper/motor_validation.dart';
import 'package:bandung_sewa_motor/app/widgets/dropdown_custom.dart';
import 'package:bandung_sewa_motor/app/widgets/textfield_custom.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/tambah_motor_controller.dart';

class TambahMotorView extends GetView<TambahMotorController> {
  const TambahMotorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff54B175),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Tambah Motor",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offNamed(Routes.LANDING_ADMIN);
            },
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Foto Motor *",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: const Color(0xff828282),
                          borderRadius: BorderRadius.circular(10)),
                      child: controller.gambarMotor.value.path != ""
                          ? GestureDetector(
                              onTap: () async {
                                await controller.getImage(true);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(controller.gambarMotor.value.path),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                await controller.getImage(true);
                              },
                              child: const Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldCustom(
                    label: "Nama Motor *",
                    fontWeight: FontWeight.bold,
                    controller: controller.namaMotor,
                    hintText: "Contoh : Vario 125",
                    obscureText: false,
                    validator: MotorValidation.namaMotor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownCustom(
                    label: "Merek *",
                    fontWeight: FontWeight.bold,
                    hintText: "Honda",
                    value: controller.selectedMerek.value,
                    items: controller.merekOptions,
                    onChanged: controller.merekChanged,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldCustom(
                    label: "Jumlah Motor *",
                    fontWeight: FontWeight.bold,
                    controller: controller.jumlahMotor,
                    keyboardType: TextInputType.number,
                    hintText: "Contoh : 2",
                    obscureText: false,
                    validator: MotorValidation.jumlahMotor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldCustom(
                    label: "Harga (Perhari) *",
                    fontWeight: FontWeight.bold,
                    controller: controller.hargaMotor,
                    keyboardType: TextInputType.number,
                    hintText: "Contoh : Rp. 80.000",
                    obscureText: false,
                    validator: MotorValidation.hargaMotor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldCustom(
                    label: "CC *",
                    fontWeight: FontWeight.bold,
                    controller: controller.cc,
                    keyboardType: TextInputType.number,
                    hintText: "Contoh : 120",
                    obscureText: false,
                    validator: MotorValidation.ccMotor,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 44,
                    child: Obx(() {
                      return ElevatedButton(
                        onPressed: () async {
                          controller.submit();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xff54B175), // background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                            : const Text(
                                "Tambah",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                      );
                    }),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
