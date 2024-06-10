import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userID;
  String name;
  String email;
  String phone;
  String gambarUrl;
  String ktpUrl;
  String hotelUrl;
  String simUrl;

  UserModel({
    required this.userID,
    required this.name,
    required this.email,
    required this.phone,
    this.gambarUrl = '',
    this.ktpUrl = '',
    this.hotelUrl = '',
    this.simUrl = '',
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      userID: data['userID'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      gambarUrl: data['gambarUrl'],
      ktpUrl: data['ktpUrl'],
      hotelUrl: data['hotelUrl'],
      simUrl: data['simUrl'],
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      userID: doc.id,
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      gambarUrl: data['gambarUrl'],
      ktpUrl: data['ktpUrl'],
      hotelUrl: data['hotelUrl'],
      simUrl: data['simUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'phone': phone,
      'gambarUrl': gambarUrl,
      'ktpUrl': ktpUrl,
      'hotelUrl': hotelUrl,
      'simUrl': simUrl,
    };
  }
}
