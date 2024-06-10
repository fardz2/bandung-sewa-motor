import 'package:cloud_firestore/cloud_firestore.dart';

class PesananModel {
  String pesananID;
  String userID;
  String motorID;
  String tanggalAwal;
  String tanggalAkhir;
  String status;
  bool antar;
  Map<String, dynamic> rincianHarga;
  String? lokasiAntar;
  String? konfirmasiID;
  String? pembayaranID;

  PesananModel({
    required this.pesananID,
    required this.userID,
    required this.motorID,
    required this.tanggalAwal,
    required this.tanggalAkhir,
    required this.status,
    required this.antar,
    required this.rincianHarga,
    this.lokasiAntar = "",
    this.konfirmasiID = "",
    this.pembayaranID = "",
  });

  factory PesananModel.fromMap(Map<String, dynamic> data) {
    return PesananModel(
      pesananID: data['pesananID'],
      userID: data['userID'],
      motorID: data['motorID'],
      tanggalAwal: data['tanggalAwal'],
      tanggalAkhir: data['tanggalAkhir'],
      status: data['status'],
      antar: data['antar'],
      rincianHarga: data['rincianHarga'] as Map<String, dynamic>,
      lokasiAntar: data['lokasiAntar'],
      konfirmasiID: data['konfirmasiID'],
      pembayaranID: data['pembayaranID'],
    );
  }

  factory PesananModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PesananModel(
      pesananID: data['pesananID'],
      userID: data['userID'],
      motorID: data['motorID'],
      tanggalAwal: data['tanggalAwal'],
      tanggalAkhir: data['tanggalAkhir'],
      status: data['status'],
      antar: data['antar'],
      rincianHarga: data['rincianHarga'] as Map<String, dynamic>,
      lokasiAntar: data['lokasiAntar'],
      konfirmasiID: data['konfirmasiID'],
      pembayaranID: data['pembayaranID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pesananID': pesananID,
      'userID': userID,
      'motorID': motorID,
      'tanggalAwal': tanggalAwal,
      'tanggalAkhir': tanggalAkhir,
      'status': status,
      'antar': antar,
      'rincianHarga': rincianHarga,
      'lokasiAntar': lokasiAntar,
      'konfirmasiID': konfirmasiID,
      'pembayaranID': pembayaranID,
    };
  }
}
