import 'package:bandung_sewa_motor/app/modules/home/views/home_view.dart';
import 'package:bandung_sewa_motor/app/modules/profile_pelanggan/views/profile_pelanggan_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({super.key});

  final TextStyle unselectedLabelStyle =
      const TextStyle(fontWeight: FontWeight.w400, fontSize: 12);

  final TextStyle selectedLabelStyle =
      const TextStyle(fontWeight: FontWeight.w400, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: SizedBox(
          height: 54,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: Colors.white,
            unselectedItemColor: const Color(0xff828282),
            selectedItemColor: const Color(0xff54B175),
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/beranda.png',
                  height: 20.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/beranda_aktif.png',
                  height: 20.0,
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/pesanan.png',
                  height: 20.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/pesanan_aktif.png',
                  height: 20.0,
                ),
                label: 'Pesanan',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/akun.png',
                  height: 20.0,
                ),
                activeIcon: Image.asset(
                  'assets/icons/akun_aktif.png',
                  height: 20.0,
                ),
                label: 'Akun',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: const Color(0xff54B175).withOpacity(0.2),
              highlightColor: Colors.transparent,
            ),
            child: buildBottomNavigationMenu(context, controller)),
        body: Obx(() => IndexedStack(
              index: controller.tabIndex.value,
              children: const [
                HomeView(),
              ],
            )),
      ),
    );
  }
}
