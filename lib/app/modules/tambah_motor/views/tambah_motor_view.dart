import 'package:bandung_sewa_motor/app/helper/motor_validation.dart';
import 'package:bandung_sewa_motor/app/widgets/button_custom.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fotor Motor *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Nama Motor *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.namaMotor,
                    decoration: InputDecoration(
                        hintText: "Contoh : Vario 125",
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: MotorValidation.namaMotor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Merek *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    value: controller.selectedMerek.value,
                    onChanged: controller.merekChanged,
                    items: controller.merekOptions.map((merek) {
                      return DropdownMenuItem(
                        value: merek,
                        child: Text(merek),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: "Contoh : Vario 125",
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Jumlah Motor *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.jumlahMotor,
                    decoration: InputDecoration(
                        hintText: "Contoh : Vario 125",
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: MotorValidation.jumlahMotor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Harga (perhari) *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.hargaMotor,
                    decoration: InputDecoration(
                        hintText: "Contoh : Vario 125",
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: MotorValidation.hargaMotor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "CC *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.cc,
                    decoration: InputDecoration(
                        hintText: "Contoh : Vario 125",
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: MotorValidation.ccMotor,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ButtonCustom(
                      name: "Tambah Motor", onPressed: controller.submit)
                ],
              )),
        ),
      ),
    );
  }
}
