import 'package:flutter/material.dart';

// Custom card motor untuk tampilah pada halaman search
class CardSearch extends StatelessWidget {
  final String image;
  final String nama;
  final String merek;
  final String harga;
  final void Function()? onTap;
  const CardSearch(
      {super.key,
      required this.nama,
      required this.merek,
      required this.harga,
      required this.image,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffF9F9FB),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.only(bottom: 20),
        margin: const EdgeInsets.only(bottom: 30),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.network(image),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    merek,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    harga,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
