import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/textfield_custom.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54B175),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                StreamBuilder<UserModel>(
                    stream: controller.getDetailImage(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Obx(() {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              controller.getImage(true);
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: snapshot.data!.gambarUrl == ""
                                    ? const Color(0xff54B175)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: controller.gambarUrl.value.path != ""
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                        File(controller.gambarUrl.value.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : snapshot.data!.gambarUrl != ""
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            snapshot.data!.gambarUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.person,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                            ),
                          ),
                        );
                      });
                    }),
                const SizedBox(height: 20),
                TextFieldCustom(
                  obscureText: false,
                  label: 'Nama Lengkap',
                  hintText: 'Nama Lengkap',
                  controller: controller.namaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    } else if (value.length < 3) {
                      return 'Nama minimal 3 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  enabled: false,
                  obscureText: false,
                  label: 'Email',
                  hintText: 'Email',
                  controller: controller.emailController,
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  obscureText: false,
                  label: 'Nomor Hp',
                  hintText: 'Nomor Hp',
                  controller: controller.noHpController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nomor Hp tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  child: Obx(() {
                    return ElevatedButton(
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          await controller.updateProfile();
                          Get.offNamedUntil(Routes.LANDING,
                              ModalRoute.withName(Routes.LANDING));
                        }
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
                              "Simpan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
