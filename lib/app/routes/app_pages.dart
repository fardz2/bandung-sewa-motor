import 'package:get/get.dart';

import 'package:bandung_sewa_motor/app/modules/detail_motor/bindings/detail_motor_binding.dart';
import 'package:bandung_sewa_motor/app/modules/detail_motor/views/detail_motor_view.dart';
import 'package:bandung_sewa_motor/app/modules/pesanan/bindings/pesanan_binding.dart';
import 'package:bandung_sewa_motor/app/modules/pesanan/views/pesanan_view.dart';
import 'package:bandung_sewa_motor/app/modules/reset/bindings/reset_binding.dart';
import 'package:bandung_sewa_motor/app/modules/reset/views/reset_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LANDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.RESET,
      page: () => ResetView(),
      binding: ResetBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MOTOR,
      page: () => DetailMotorView(),
      binding: DetailMotorBinding(),
    ),
    GetPage(
      name: _Paths.PESANAN,
      page: () => PesananView(),
      binding: PesananBinding(),
    ),
  ];
}
