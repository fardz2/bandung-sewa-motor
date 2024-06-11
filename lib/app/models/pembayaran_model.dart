import 'package:cloud_firestore/cloud_firestore.dart';

class PembayaranModel {
  String pembayaranID;
  String rentalID;
  String userID;
  int totalHarga;
  String buktiPembayaran;
  String metode;
  String status;

  PembayaranModel({
    required this.pembayaranID,
    required this.rentalID,
    required this.userID,
    required this.totalHarga,
    required this.buktiPembayaran,
    required this.metode,
    required this.status,
  });

  factory PembayaranModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    return PembayaranModel(
      pembayaranID: documentId,
      rentalID: data['rentalID'],
      userID: data['userID'],
      totalHarga: data['totalHarga'],
      buktiPembayaran: data['buktiPembayaran'],
      metode: data['metode'],
      status: data['status'],
    );
  }

  factory PembayaranModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PembayaranModel(
      pembayaranID: doc.id,
      rentalID: data['rentalID'],
      userID: data['userID'],
      totalHarga: data['totalHarga'],
      buktiPembayaran: data['buktiPembayaran'],
      metode: data['metode'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rentalID': rentalID,
      'userID': userID,
      'totalHarga': totalHarga,
      'buktiPembayaran': buktiPembayaran,
      'metode': metode,
      'status': status,
    };
  }
}
