import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/textfield_custom.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Registrasi',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      const Text(
                        "Buat akunmu dan nikmati sewa motor di bandung dengan mudah",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff8A8A8E),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      //label
                      TextFieldCustom(
                        label: 'Nama Lengkap',
                        hintText: 'Nama Lengkap',
                        controller: controller.namaLengkapController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      //label
                      TextFieldCustom(
                        label: 'No HP',
                        hintText: '08223232323',
                        controller: controller.noHpController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'No Hp is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextFieldCustom(
                        label: 'Email',
                        hintText: 'Email',
                        controller: controller.emailController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Obx(() {
                        return TextFieldCustom(
                          label: 'Password',
                          hintText: 'Password',
                          controller: controller.passwordController,
                          obscureText: controller.obscureText.value,
                          suffixIcon: IconButton(
                            icon: Icon(controller.obscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              controller.togglePasswordVisibility();
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        );
                      }),
                      const SizedBox(
                        height: 14,
                      ),
                      Obx(() {
                        return TextFieldCustom(
                          label: 'Konfirmasi Password',
                          hintText: 'Konfirmasi Password',
                          controller: controller.confirmPasswordController,
                          obscureText: controller.konfirmasiObscureText.value,
                          suffixIcon: IconButton(
                            icon: Icon(controller.konfirmasiObscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              controller.toggleKonfirmasiPasswordVisibility();
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm password is required';
                            }
                            if (value != controller.passwordController.text) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                        );
                      }),
                      const SizedBox(
                        height: 24,
                      ),
                      Obx(() {
                        return ElevatedButton(
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              controller.register();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff54B175),
                            minimumSize: const Size(double.infinity, 50),
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
                                  'Buat Akun',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah punya akun?',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(Routes.LOGIN);
                        },
                        child: const Text(
                          ' Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
