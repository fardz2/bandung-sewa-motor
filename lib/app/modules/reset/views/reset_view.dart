import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reset_controller.dart';

class ResetView extends GetView<ResetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 131, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reset Password',
              style: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Masukkan email untuk reset password',
              style: TextStyle(
                color: Colors.black26,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              'Email',
              style: TextStyle(
                color: Colors.black26,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                hintText: 'user@gmail.com',
                hintStyle: const TextStyle(
                  color: Colors.black26,
                  fontSize: 16,
                  fontFamily: 'QuickSand',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            const SizedBox(height: 45),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () =>
                    controller.resetPassword(controller.emailController.text),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 0x54, 0xB1, 0x75)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: const Text(
                  'Kirim',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'QuickSand',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
