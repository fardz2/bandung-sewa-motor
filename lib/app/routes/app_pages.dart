import 'package:get/get.dart';

import '../modules/detail_pembayaran/bindings/detail_pembayaran_binding.dart';
import '../modules/detail_pembayaran/views/detail_pembayaran_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/profile_pelanggan/bindings/profile_pelanggan_binding.dart';
import '../modules/profile_pelanggan/views/profile_pelanggan_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/tambah_motor/bindings/tambah_motor_binding.dart';
import '../modules/tambah_motor/views/tambah_motor_view.dart';

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
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PEMBAYARAN,
      page: () => const DetailPembayaranView(),
      binding: DetailPembayaranBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PELANGGAN,
      page: () => const ProfilePelangganView(),
      binding: ProfilePelangganBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_MOTOR,
      page: () => const TambahMotorView(),
      binding: TambahMotorBinding(),
    ),
  ];
}
