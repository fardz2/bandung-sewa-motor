import 'package:cloud_firestore/cloud_firestore.dart';

class MotorModel {
  MotorModel({
    required this.cc,
    required this.gambarUrl,
    required this.harga,
    required this.jumlah,
    required this.merek,
    required this.motorId,
    required this.namaMotor,
    required this.status,
  });

  int cc;
  String gambarUrl;
  int harga;
  int jumlah;
  String merek;
  String motorId;
  String namaMotor;
  String status;

  factory MotorModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MotorModel(
      cc: data['cc'],
      gambarUrl: data['gambarUrl'],
      harga: data['harga'],
      jumlah: data['jumlah'],
      merek: data['merek'],
      motorId: data['motorID'],
      namaMotor: data['namaMotor'],
      status: data['status'],
    );
  }

  factory MotorModel.fromJson(Map<String, dynamic> json) => MotorModel(
        cc: json["cc"],
        gambarUrl: json["gambarUrl"],
        harga: json["harga"],
        jumlah: json["jumlah"],
        merek: json["merek"],
        motorId: json["motorID"],
        namaMotor: json["namaMotor"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "cc": cc,
        "gambarUrl": gambarUrl,
        "harga": harga,
        "jumlah": jumlah,
        "merek": merek,
        "motorID": motorId,
        "namaMotor": namaMotor,
        "status": status,
      };
}
