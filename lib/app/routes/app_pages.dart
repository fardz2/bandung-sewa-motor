import 'package:get/get.dart';

import '../modules/detailmotoradmin/bindings/detailmotoradmin_binding.dart';
import '../modules/detailmotoradmin/views/detailmotoradmin_view.dart';

import '../modules/bukti_pembayaran/bindings/bukti_pembayaran_binding.dart';
import '../modules/bukti_pembayaran/views/bukti_pembayaran_view.dart';
import '../modules/detail_motor/bindings/detail_motor_binding.dart';
import '../modules/detail_motor/views/detail_motor_view.dart';
import '../modules/detail_pembayaran/bindings/detail_pembayaran_binding.dart';
import '../modules/detail_pembayaran/views/detail_pembayaran_view.dart';
import '../modules/detail_pesanan/bindings/detail_pesanan_binding.dart';
import '../modules/detail_pesanan/views/detail_pesanan_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_admin/bindings/home_admin_binding.dart';
import '../modules/home_admin/views/home_admin_view.dart';
import '../modules/konfirmasi_pesanan/bindings/konfirmasi_pesanan_binding.dart';
import '../modules/konfirmasi_pesanan/views/konfirmasi_pesanan_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';

import '../modules/persyaratan/bindings/persyaratan_binding.dart';
import '../modules/persyaratan/views/persyaratan_view.dart';
import '../modules/sewamotor/bindings/sewamotor_binding.dart';
import '../modules/sewamotor/views/sewamotor_view.dart';

import '../modules/landing_admin/bindings/landing_admin_binding.dart';
import '../modules/landing_admin/views/landing_admin_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/metode_bayar/bindings/metode_bayar_binding.dart';
import '../modules/metode_bayar/views/metode_bayar_view.dart';
import '../modules/pesanan/bindings/pesanan_binding.dart';
import '../modules/pesanan/views/pesanan_view.dart';
import '../modules/pesanan_admin/bindings/pesanan_admin_binding.dart';
import '../modules/pesanan_admin/views/pesanan_admin_view.dart';
import '../modules/profile_admin/bindings/profile_admin_binding.dart';
import '../modules/profile_admin/views/profile_admin_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset/bindings/reset_binding.dart';
import '../modules/reset/views/reset_view.dart';
import '../modules/search_motor/bindings/search_motor_binding.dart';
import '../modules/search_motor/views/search_view.dart';
import '../modules/tambah_motor/bindings/tambah_motor_binding.dart';
import '../modules/tambah_motor/views/tambah_motor_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

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
      name: _Paths.PERSYARATAN,
      page: () => const PersyaratanView(),
      binding: PersyaratanBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RESET,
      page: () => ResetView(),
      binding: ResetBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MOTOR,
      page: () => const DetailMotorView(),
      binding: DetailMotorBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_MOTOR,
      page: () => const TambahMotorView(),
      binding: TambahMotorBinding(),
    ),
    GetPage(
      name: _Paths.PESANAN,
      page: () => const PesananView(),
      binding: PesananBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_MOTOR,
      page: () => const SearchMotorView(),
      binding: SearchMotorBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PEMBAYARAN,
      page: () => const DetailPembayaranView(),
      binding: DetailPembayaranBinding(),
    ),
    GetPage(
      name: _Paths.DETAILMOTORADMIN,
      page: () => const DetailmotoradminView(),
      binding: DetailmotoradminBinding(),
    ),
    GetPage(
      name: _Paths.SEWAMOTOR,
      page: () => const SewamotorView(),
      binding: SewamotorBinding(),
    ),
    GetPage(
      name: _Paths.HOME_ADMIN,
      page: () => const HomeAdminView(),
      binding: HomeAdminBinding(),
    ),
    GetPage(
      name: _Paths.LANDING_ADMIN,
      page: () => const LandingAdminView(),
      binding: LandingAdminBinding(),
    ),
    GetPage(
      name: _Paths.PESANAN_ADMIN,
      page: () => const PesananAdminView(),
      binding: PesananAdminBinding(),
    ),
    GetPage(
      name: _Paths.METODE_BAYAR,
      page: () => const MetodeBayarView(),
      binding: MetodeBayarBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PESANAN,
      page: () => const DetailPesananView(),
      binding: DetailPesananBinding(),
    ),
    GetPage(
      name: _Paths.BUKTI_PEMBAYARAN,
      page: () => const BuktiPembayaranView(),
      binding: BuktiPembayaranBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_ADMIN,
      page: () => const ProfileAdminView(),
      binding: ProfileAdminBinding(),
    ),
    GetPage(
      name: _Paths.KONFIRMASI_PESANAN,
      page: () => const KonfirmasiPesananView(),
      binding: KonfirmasiPesananBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_MOTOR,
      page: () => const TambahMotorView(),
      binding: TambahMotorBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PELANGGAN,
      page: () => const ProfilePelangganView(),
      binding: ProfilePelangganBinding(),
    ),
  ];
}
