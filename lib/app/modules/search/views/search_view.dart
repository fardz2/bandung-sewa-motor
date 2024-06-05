import 'package:bandung_sewa_motor/app/widgets/card_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xffC5C5C7),
                    ),
                    hintText: "Honda, Yamaha",
                    fillColor: const Color(0xFFF4F4F4),
                    filled: true,
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.0),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: 3,
                  itemBuilder: ((context, index) => const CardSearch(
                      image: "assets/images/beat.png",
                      nama: "Honda 2018",
                      merek: "Honda",
                      harga: "80K/perhari"))),
            )
          ],
        ),
      ),
    );
  }
}
