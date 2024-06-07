import 'package:bandung_sewa_motor/app/helper/format_harga.dart';
import 'package:bandung_sewa_motor/app/models/motor_model.dart';
import 'package:bandung_sewa_motor/app/modules/search_motor/controllers/search_controller.dart';
import 'package:bandung_sewa_motor/app/routes/app_pages.dart';

import 'package:bandung_sewa_motor/app/widgets/card_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchMotorView extends GetView<SearchMotorController> {
  const SearchMotorView({super.key});

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
                onChanged: (value) => controller.search.value = value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xffC5C5C7),
                  ),
                  fillColor: const Color(0xFFF4F4F4),
                  filled: true,
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                return StreamBuilder<List<MotorModel>>(
                  stream: controller.getMotorSearch(controller.search.value),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No results found'),
                      );
                    }
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CardSearch(
                          image: snapshot.data![index].gambarUrl,
                          nama: snapshot.data![index].namaMotor,
                          merek: snapshot.data![index].merek,
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_MOTOR);
                          },
                          harga:
                              "${FormatHarga.formatRupiah(snapshot.data![index].harga)}/perhari",
                        );
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
