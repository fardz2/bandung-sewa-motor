// Validation motor
class MotorValidation {
  static String? namaMotor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama motor tidak boleh kosong';
    }
    return null;
  }

  // static String? merekMotor(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Pilih merek motor';
  //   }
  //   return null;
  // }

  static String? jumlahMotor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Jumlah motor tidak boleh kosong';
    }
    return null;
  }

  static String? hargaMotor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Harga tidak boleh kosong';
    }
    return null;
  }

  static String? ccMotor(String? value) {
    if (value == null || value.isEmpty) {
      return 'CC tidak boleh kosong';
    }
    return null;
  }
}
