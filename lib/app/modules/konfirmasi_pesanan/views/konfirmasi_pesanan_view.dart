import 'package:bandung_sewa_motor/app/models/pembayaran_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:widget_zoom/widget_zoom.dart';

import '../../../helper/format_harga.dart';
import '../../../models/motor_model.dart';
import '../../../models/pesanan_model.dart';
import '../../../models/user_model.dart';
import '../controllers/konfirmasi_pesanan_controller.dart';

class KonfirmasiPesananView extends GetView<KonfirmasiPesananController> {
  const KonfirmasiPesananView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'Konfirmasi Pesanan',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'No. Pesanan: ${controller.pesananID}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff54B175),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<PesananModel>(
          stream: controller.getDetailPesanan(),
          builder: (context, pesananSnapshot) {
            if (!pesananSnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      pesananSnapshot.data!.status,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff54B175),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  StreamBuilder<MotorModel>(
                      stream: controller
                          .getMotorData(pesananSnapshot.data!.motorID),
                      builder: (context, motorSnapshot) {
                        if (!motorSnapshot.hasData) {
                          return const Center(
                            child: SizedBox(),
                          );
                        }
                        controller.jumlahMotor.value =
                            motorSnapshot.data!.jumlah;
                        return Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xffEFEFF0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: motorSnapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const SizedBox()
                                    : Image.network(
                                        motorSnapshot.data!.gambarUrl,
                                        width: 40,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${motorSnapshot.data!.merek} ${motorSnapshot.data!.namaMotor}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Bandung Sewa Motor",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff4F4F4F),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/check_icon.png",
                        width: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        pesananSnapshot.data!.antar
                            ? "Diantar"
                            : "Ambil Di Tempat",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff4F4F4F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset(
                        "assets/icons/warning_icon.png",
                        width: 18,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Tidak bisa reschedule",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff4F4F4F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Data Penyewa",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  StreamBuilder<UserModel>(
                      stream:
                          controller.getUserData(pesananSnapshot.data!.userID),
                      builder: (context, userSnapshot) {
                        if (!userSnapshot.hasData) {
                          return const Center(
                            child: SizedBox(),
                          );
                        }
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Text(
                            "${userSnapshot.data!.name} ( ${userSnapshot.data!.phone} )",
                            style: const TextStyle(color: Color(0xff4F4F4F)),
                          ),
                        );
                      }),
                  const SizedBox(height: 16),
                  Text(
                    pesananSnapshot.data!.antar
                        ? "Lokasi Antar *"
                        : "Lokasi Pengambilan *",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pesananSnapshot.data!.antar
                        ? pesananSnapshot.data!.lokasiAntar.toString()
                        : "Jl. Melati II No. 30 Blok 8 Perumahan Sadang Serang Kel. Sekeloa Kec. Coblong",
                    style: const TextStyle(color: Color(0xff4F4F4F)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Lokasi Pengembalian *",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Jl. Melati II No. 30 Blok 8 Perumahan Sadang Serang Kel. Sekeloa Kec. Coblong",
                    style: TextStyle(color: Color(0xff4F4F4F)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Durasi Sewa *",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Pengambilan :",
                            style: TextStyle(color: Color(0xff8A8A8E)),
                          ),
                          Text(
                            pesananSnapshot.data!.tanggalAwal,
                          ),
                        ],
                      ),
                      Container(
                        height: 24,
                        width: 1,
                        color: const Color(0xff4F4F4F),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Pengembalian :",
                            style: TextStyle(color: Color(0xff8A8A8E)),
                          ),
                          Text(
                            pesananSnapshot.data!.tanggalAkhir,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Rincian Bayar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Harga Sewa (${DateFormat("dd MMMM yyyy", "id_ID").parse(pesananSnapshot.data!.tanggalAkhir).difference(DateFormat("dd MMMM yyyy", "id_ID").parse(pesananSnapshot.data!.tanggalAwal)).inDays + 1})",
                        style: const TextStyle(color: Color(0xff8A8A8E)),
                      ),
                      Text(
                        FormatHarga.formatRupiah(
                            pesananSnapshot.data!.rincianHarga['totalHarga']),
                        style: const TextStyle(color: Color(0xff8A8A8E)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  pesananSnapshot.data!.antar
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Ongkos Antar",
                              style: TextStyle(color: Color(0xffF37921)),
                            ),
                            Text(
                              FormatHarga.formatRupiah(
                                  pesananSnapshot.data!.rincianHarga['ongkir']),
                              style: const TextStyle(color: Color(0xffF37921)),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Bayar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8A8A8E)),
                      ),
                      Text(
                        FormatHarga.formatRupiah(
                            pesananSnapshot.data!.rincianHarga['totalHarga'] +
                                pesananSnapshot.data!.rincianHarga['ongkir']),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8A8A8E)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Bukti Pembayaran",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  StreamBuilder<PembayaranModel>(
                      stream: controller.getPembayaranData(
                          pesananSnapshot.data!.pembayaranID.toString()),
                      builder: (context, pembayaranSnapshot) {
                        if (!pembayaranSnapshot.hasData) {
                          return const Center(
                            child: SizedBox(),
                          );
                        }
                        return pembayaranSnapshot.data!.metode == "transfer"
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: const Color(0xff828282),
                                    borderRadius: BorderRadius.circular(10)),
                                child: pembayaranSnapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? const SizedBox()
                                    : WidgetZoom(
                                        heroAnimationTag: pembayaranSnapshot
                                            .data!.buktiPembayaran,
                                        zoomWidget: Image.network(
                                          pembayaranSnapshot
                                              .data!.buktiPembayaran,
                                        ),
                                      ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    pembayaranSnapshot.data!.metode,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              );
                      }),
                  const SizedBox(height: 16),
                  StreamBuilder<UserModel>(
                      stream:
                          controller.getUserData(pesananSnapshot.data!.userID),
                      builder: (context, userSnapshot) {
                        if (!userSnapshot.hasData) {
                          return const Center(
                            child: SizedBox(),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Foto KTP",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  color: const Color(0xff828282),
                                  borderRadius: BorderRadius.circular(10)),
                              child: userSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? const SizedBox()
                                  : WidgetZoom(
                                      heroAnimationTag:
                                          userSnapshot.data!.ktpUrl,
                                      zoomWidget: Image.network(
                                        userSnapshot.data!.ktpUrl,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Foto SIM C",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  color: const Color(0xff828282),
                                  borderRadius: BorderRadius.circular(10)),
                              child: userSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? const SizedBox()
                                  : WidgetZoom(
                                      heroAnimationTag:
                                          userSnapshot.data!.simUrl,
                                      zoomWidget: Image.network(
                                        userSnapshot.data!.simUrl,
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Bukti Reservasi Hotel",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  color: const Color(0xff828282),
                                  borderRadius: BorderRadius.circular(10)),
                              child: userSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? const SizedBox()
                                  : WidgetZoom(
                                      heroAnimationTag:
                                          userSnapshot.data!.hotelUrl,
                                      zoomWidget: Image.network(
                                        userSnapshot.data!.hotelUrl,
                                      ),
                                    ),
                            ),
                          ],
                        );
                      }),
                  const SizedBox(height: 32),
                  pesananSnapshot.data!.status == "Ditolak" ||
                          pesananSnapshot.data!.status == "Dibatalkan" ||
                          pesananSnapshot.data!.status == "Dikembalikan"
                      ? const SizedBox()
                      : Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.dialog(AlertDialog(
                                  title: const Text('Konfirmasi Pesanan'),
                                  content: Text(pesananSnapshot.data!.status ==
                                          "Menunggu Konfirmasi"
                                      ? 'Apakah anda yakin ingin menerima pesanan ini?'
                                      : "Apakah anda yakin ingin konfirmasi bahwa pesanan ini sudah selesai"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (pesananSnapshot.data!.status ==
                                            "Menunggu Konfirmasi") {
                                          controller.konfirmasiPesanan(
                                            "terima",
                                            pesananSnapshot.data!.pesananID,
                                            pesananSnapshot.data!.status,
                                            pesananSnapshot.data!.motorID,
                                          );
                                        } else {
                                          controller.konfirmasiPesanan(
                                              "kembalikan",
                                              pesananSnapshot.data!.pesananID,
                                              pesananSnapshot.data!.status,
                                              pesananSnapshot.data!.motorID);
                                        }
                                        Get.back();
                                      },
                                      child: const Text('Ya'),
                                    ),
                                  ],
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff54B175),
                                minimumSize: const Size(double.infinity, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                pesananSnapshot.data!.status ==
                                        "Menunggu Konfirmasi"
                                    ? "Konfirmasi Pesanan"
                                    : "Sudah Dikembalikan",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.dialog(AlertDialog(
                                  title: const Text('Konfirmasi Pesanan'),
                                  content: Text(pesananSnapshot.data!.status ==
                                          "Menunggu Konfirmasi"
                                      ? 'Apakah anda yakin ingin tolak pesanan ini?'
                                      : "Apakah anda yakin ingin konfirmasi bahwa pesanan dibatalkan"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (pesananSnapshot.data!.status ==
                                            "Menunggu Konfirmasi") {
                                          controller.konfirmasiPesanan(
                                              "tolak",
                                              pesananSnapshot.data!.pesananID,
                                              pesananSnapshot.data!.status,
                                              pesananSnapshot.data!.motorID);
                                        } else {
                                          controller.konfirmasiPesanan(
                                              "batalkan",
                                              pesananSnapshot.data!.pesananID,
                                              pesananSnapshot.data!.status,
                                              pesananSnapshot.data!.motorID);
                                        }
                                        Get.back();
                                      },
                                      child: const Text('Ya'),
                                    ),
                                  ],
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                      color: Color(0xff8A8A8E)),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                pesananSnapshot.data!.status ==
                                        "Menunggu Konfirmasi"
                                    ? "Tolak Pesanan"
                                    : "Batalkan Pesanan",
                                style: const TextStyle(
                                  color: Color(0xff8A8A8E),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }),
    );
  }
}
