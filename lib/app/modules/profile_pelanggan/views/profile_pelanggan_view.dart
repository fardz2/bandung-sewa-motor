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
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff54B175), width: 2),
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
                              ]),
                          child: snapshot.data!.gambarUrl == ""
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    snapshot.data!.gambarUrl,
                                    fit: BoxFit.cover,
                                  ),
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
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "(${snapshot.data!.phone})",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 106, 106, 106),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.EDIT_PROFILE,
                          arguments: snapshot.data!.userID);
                    },
                    leading: const Icon(Icons.manage_accounts),
                    title: const Text(
                      "Edit Profile",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                    child: ListTile(
                      leading: const Icon(Icons.logout),
                      title: Obx(() {
                        return controller.isLoading.value
                            ? const LinearProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff54B175),
                                ),
                              )
                            : const Text(
                                "Logout",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              );
                      }),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
