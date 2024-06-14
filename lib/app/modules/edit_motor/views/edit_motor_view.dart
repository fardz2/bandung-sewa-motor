import 'dart:io';

import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helper/motor_validation.dart';
import '../../../widgets/button_custom.dart';
import '../../../widgets/dropdown_custom.dart';
import '../../../widgets/textfield_custom.dart';
import '../controllers/edit_motor_controller.dart';

class EditMotorView extends GetView<EditMotorController> {
  const EditMotorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xff54B175),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Edit Motor",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
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
                  StreamBuilder<MotorModel>(
                      stream: controller.getDetailImage(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          controller.gambarMotorUrl.value =
                              snapshot.data!.gambarUrl;
                          return Obx(() {
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
                                          File(controller
                                              .gambarMotor.value.path),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        await controller.getImage(true);
                                      },
                                      child: Image.network(
                                        snapshot.data!.gambarUrl,
                                      ),
                                    ),
                            );
                          });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
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
                  Obx(() {
                    return DropdownCustom(
                      label: "Merek *",
                      fontWeight: FontWeight.bold,
                      hintText: "Honda",
                      value: controller.selectedMerek.value,
                      items: controller.merekOptions,
                      onChanged: controller.merekChanged,
                    );
                  }),
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
                  ButtonCustom(name: "Edit Motor", onPressed: controller.submit)
                ],
              )),
        ),
      ),
    );
  }
}
