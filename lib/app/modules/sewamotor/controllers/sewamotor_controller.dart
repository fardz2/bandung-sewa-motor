import 'package:get/get.dart';

class SewamotorController extends GetxController {
  //TODO: Implement SewamotorController

  final count = 0.obs;
  final opsi = "ambil".obs;
  void selectOption(String opsi) {
    this.opsi.value = opsi;
  }
}
