import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_motor_controller.dart';
// import 'package:bandung_sewa_motor/app/modules/pesanan/views/pesanan_view.dart';

class DetailMotorView extends GetView<DetailMotorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        title: const Text(
          'Detail',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 0x54, 0xB1, 0x75),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image
              SizedBox(
                height: 300,
                child: Image.asset(
                  'assets/images/beat.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18),
                    Text(
                      'Honda Beat 2018',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Honda',
                      style: TextStyle(fontSize: 18, color: Colors.black26),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '125cc',
                      style: TextStyle(fontSize: 18, color: Colors.black26),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Fitur',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              // Feature Card 1
                              featureCard(
                                imagePath: 'assets/images/helm.png',
                                text: '2 Helm',
                              ),
                              SizedBox(width: 16),
                              // Feature Card 2
                              featureCard(
                                imagePath: 'assets/images/jas.png',
                                text: '2 Jas Hujan',
                              ),
                              SizedBox(width: 16),
                              // Feature Card 3
                              featureCard(
                                imagePath: 'assets/images/driver.png',
                                text: 'Antar motor',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white, // Set background color to white
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rp.80.000',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Per Hari',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => PesananView()),
                      // );
                    },
                    child: Text(
                      'Pesan Sekarang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0x54, 0xB1, 0x75)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget featureCard({required String imagePath, required String text}) {
    return Container(
      height: 100,
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, height: 40),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
