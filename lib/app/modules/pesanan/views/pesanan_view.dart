import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pesanan_controller.dart';

class PesananView extends GetView<PesananController> {
  const PesananView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesanan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 0x54, 0xB1, 0x75),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            width: 370,
            height: 220,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'No. Pesanan SMJ00233',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Rab, 23 Jun 2021',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ]),
                Divider(height: 20, color: Colors.grey[300]),
                Text(
                  'Honda Beat 2018',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sewa Motor Lempuyangan',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Rp 120.000',
                      style: TextStyle(fontSize: 17, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 335,
                          height: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 239, 243, 243),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'Konfirmasi Pesanan',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0x54, 0xB1, 0x75),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 30,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xff54B175),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.asset(
                                'assets/images/row.png',
                                width: 35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
