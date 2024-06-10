import 'package:bandung_sewa_motor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helper/format_harga.dart';
import '../../../models/user_model.dart';
import '../../../widgets/kategori_bubble.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<UserModel>(
                  stream: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Halo, ${snapshot.data!.name}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.SEARCH_MOTOR);
                          },
                          child:
                              Image.asset('assets/icons/search.png', width: 24),
                        ),
                      ],
                    );
                  }),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                height: 140,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/home_banner.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                "Motor Tersedia",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() {
                  return Row(
                    children: [
                      KategoriBubble(
                        text: 'All',
                        isSelected: controller.selectedCategory.value == 'All',
                        onTap: () => controller.selectCategory('All'),
                      ),
                      const SizedBox(width: 16),
                      KategoriBubble(
                        text: 'Honda',
                        isSelected:
                            controller.selectedCategory.value == 'Honda',
                        onTap: () => controller.selectCategory('Honda'),
                      ),
                      const SizedBox(width: 16),
                      KategoriBubble(
                        text: 'Yamaha',
                        isSelected:
                            controller.selectedCategory.value == 'Yamaha',
                        onTap: () => controller.selectCategory('Yamaha'),
                      ),
                      const SizedBox(width: 16),
                      KategoriBubble(
                        text: 'Suzuki',
                        isSelected:
                            controller.selectedCategory.value == 'Suzuki',
                        onTap: () => controller.selectCategory('Suzuki'),
                      ),
                      const SizedBox(width: 16),
                      KategoriBubble(
                        text: 'Kawasaki',
                        isSelected:
                            controller.selectedCategory.value == 'Kawasaki',
                        onTap: () => controller.selectCategory('Kawasaki'),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 12),
              Obx(() {
                return StreamBuilder(
                    stream: controller.getMotorbikeByCategory(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            crossAxisCount: 2,
                            childAspectRatio: MediaQuery.of(context)
                                    .size
                                    .width /
                                (MediaQuery.of(context).size.height / 1.3 + 10),
                          ),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 140,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        color: Color(0xffF6F6F6),
                                      ),
                                      child: Image.network(
                                        snapshot.data.docs[index]
                                            .get('gambarUrl'),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${snapshot.data.docs[index].get('merek')} ${snapshot.data.docs[index].get('namaMotor')}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "${snapshot.data.docs[index].get('cc').toString()}cc",
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${FormatHarga.formatRupiah(snapshot.data.docs[index].get("harga"))}/hari',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => Get.toNamed(
                                                Routes.DETAIL_MOTOR,
                                                arguments: snapshot
                                                    .data.docs[index]
                                                    .get('motorID'),
                                              ),
                                              child: Container(
                                                width: 40,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff54B175),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Image.asset(
                                                  'assets/icons/chevron_right.png',
                                                  width: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
