import 'package:cloud_firestore/cloud_firestore.dart';

class MotorModel {
  String motorID;
  String namaMotor;
  String gambarUrl;
  String merek;
  int cc;
  int harga;
  int jumlah;
  String status;

  MotorModel({
    required this.motorID,
    required this.namaMotor,
    required this.gambarUrl,
    required this.merek,
    required this.cc,
    required this.harga,
    required this.jumlah,
    required this.status,
  });

  factory MotorModel.fromMap(Map<String, dynamic> data) {
    return MotorModel(
      motorID: data['motorID'],
      namaMotor: data['namaMotor'],
      gambarUrl: data['gambarUrl'],
      merek: data['merek'],
      cc: data['cc'],
      harga: data['harga'],
      jumlah: data['jumlah'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'motorID': motorID,
      'namaMotor': namaMotor,
      'gambarUrl': gambarUrl,
      'merek': merek,
      'cc': cc,
      'harga': harga,
      'jumlah': jumlah,
      'status': status,
    };
  }

  factory MotorModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MotorModel(
      motorID: doc.id,
      namaMotor: data['namaMotor'] as String,
      gambarUrl: data['gambarUrl'] as String,
      merek: data['merek'] as String,
      cc: data['cc'] as int,
      harga: data['harga'] as int,
      jumlah: data['jumlah'] as int,
      status: data['status'] as String,
    );
  }
}
