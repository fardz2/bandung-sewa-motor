import 'package:bandung_sewa_motor/app/widgets/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardPesanan extends StatelessWidget {
  final String noPesanan;
  final String tanggal;
  final String namaMotor;
  final String lokasi;
  final String harga;
  final VoidCallback onPressed;
  const CardPesanan(
      {super.key,
      required this.noPesanan,
      required this.tanggal,
      required this.namaMotor,
      required this.lokasi,
      required this.harga,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 1, // Set background color to white
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No. Pesanan $noPesanan",
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  tanggal,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const DottedLine(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaMotor,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      lokasi,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Rp $harga",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xffF4F4F5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Konfirmasi Pesanan',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0x54, 0xB1, 0x75),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  onPressed: onPressed,
                  icon: Image.asset(
                    'assets/images/row.png',
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xff54B175),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
