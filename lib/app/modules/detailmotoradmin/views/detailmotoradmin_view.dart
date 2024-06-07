import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../controllers/detailmotoradmin_controller.dart';

class DetailmotoradminView extends GetView<DetailmotoradminController> {
  const DetailmotoradminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54B175),
        title: const Text(
          'Detail Motor',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/images/back.png'),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<String>(
            color: Color(0xFF54B175),
            onSelected: (String result) {
              print(result); 
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Hapus',
                child: Text('Hapus', 
                style: TextStyle(color: Colors.white),),
              ),
              const PopupMenuItem<String>(
                value: 'Edit',
                child: Text('Edit',
                style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
              SizedBox(height:20),
              Container(
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/hondabeat.png"),
                    fit: BoxFit.fill,
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18),
                    Text(
                      'Beat 2018',
                      style:
                          TextStyle(fontSize: 24, 
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(34, 41, 46, 1)),
                    ),
                    Text(
                      'Honda',
                    style: TextStyle(fontSize: 12,
                      color: Color(0xFF8A8A8E),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '125cc',
                    style: TextStyle(fontSize: 12,
                      color: Color(0xFF8A8A8E),
                      )
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Fitur',
                      style:
                          TextStyle(fontSize: 24, 
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(34, 41, 46, 1)),
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
                                imagePath: 'assets/images/jashujan.png',
                                text: '2 Jas Hujan',
                              ),
                              SizedBox(width: 16),
                              // Feature Card 3
                              featureCard(
                                imagePath: 'assets/images/antarmotor.png',
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
              color: Colors.white,
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
        ],
      ),
    )
        )
        ]
      )
    );
  }

  Widget featureCard({required String imagePath, required String text}) {
    return Container(
      height: 100,
      width: 100,
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
