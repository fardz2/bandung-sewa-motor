import 'package:get/get.dart';

import '../modules/detailmotoradmin/bindings/detailmotoradmin_binding.dart';
import '../modules/detailmotoradmin/views/detailmotoradmin_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/persyaratan/bindings/persyaratan_binding.dart';
import '../modules/persyaratan/views/persyaratan_view.dart';

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
      page: () => LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.PERSYARATAN,
      page: () => const PersyaratanView(),
      binding: PersyaratanBinding(),
    ),
    GetPage(
      name: _Paths.DETAILMOTORADMIN,
      page: () => const DetailmotoradminView(),
      binding: DetailmotoradminBinding(),
    ),
  ];
}
