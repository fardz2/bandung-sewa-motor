import 'package:intl/intl.dart';

class FormatHarga {
  static String formatNumber(int number) {
    if (number >= 1000 && number < 1000000) {
      return '${(number / 1000).toStringAsFixed(0)}K';
    } else if (number >= 1000000 && number < 1000000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else {
      return number.toString();
    }
  }

  static String formatRupiah(int number) {
    final format = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return format.format(number);
  }
}
