import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_pelanggan_controller.dart';

class ProfilePelangganView extends GetView<ProfilePelangganController> {
  const ProfilePelangganView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54B175),
        title: const Text('Profile',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: const SizedBox(),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<UserModel>(
          stream: controller.getUserData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xff54B175),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data!.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          snapshot.data!.email,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(
                      snapshot.data!.phone,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.PERSYARATAN);
                    },
                    leading: Image.asset("assets/icons/persyaratan.png"),
                    title: const Text(
                      "Persyaratan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller.logout();
                      Get.snackbar('Logout', 'Logout Berhasil',
                          colorText: Colors.white, backgroundColor: Colors.red);
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.logout),
                      title: Text(
                        "Logout",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
