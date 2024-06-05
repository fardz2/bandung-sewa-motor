import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                    ),
                    Text(
                      "Akun User",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "akunuser@gmail.com",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                  "+62 83829092428",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Image.asset("assets/icons/persyaratan.png"),
                title: const Text(
                  "Persyaratan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "Logout",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}
