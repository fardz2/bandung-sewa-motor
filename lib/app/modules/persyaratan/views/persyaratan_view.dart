import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/persyaratan_controller.dart';

class PersyaratanView extends GetView<PersyaratanController> {
  const PersyaratanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54B175),
        title: const Text(
          'Persyaratan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/images/back.png'),
          color: Colors.white,
          onPressed: () {},
        ),
      ),
      body: Stack(children: [
        Center(
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
                      SizedBox(height: 10),
                      Container(
                        height: 150,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Image.asset('assets/images/camera.png'),
                            iconSize: 50,
                            onPressed: () {
                              // Tambahkan aksi di sini
                            },
                          ),
                        ),
                      ),
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
                      SizedBox(height: 10),
                      Container(
                          height: 150,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Image.asset('assets/images/camera.png'),
                              iconSize: 50,
                              onPressed: () {
                                // Tambahkan aksi di sini
                              },
                            ),
                          )),
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
                      SizedBox(height: 10),
                      Container(
                          height: 150,
                          width: 400,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: Image.asset('assets/images/camera.png'),
                              iconSize: 50,
                              onPressed: () {
                                // Tambahkan aksi di sini
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF54B175),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8)), // Button color
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
