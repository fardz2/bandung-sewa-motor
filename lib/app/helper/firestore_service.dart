import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/motor_model.dart';
import '../models/user_model.dart';

class FirestoreService extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User Collection CRUD
  Future<void> addUser(UserModel user) async {
    await _firestore.collection('users').doc(user.userID).set(user.toMap());
  }

  Future<UserModel?> getUser(String userID) async {
    DocumentSnapshot doc =
        await _firestore.collection('users').doc(userID).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // stream
  Stream<UserModel> getUserStream(String userID) {
    return _firestore
        .collection('users')
        .doc(userID)
        .snapshots()
        .map((event) => UserModel.fromFirestore(event));
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.userID).update(user.toMap());
  }

  Future<void> deleteUser(String userID) async {
    await _firestore.collection('users').doc(userID).delete();
  }

  // Motor Collection CRUD
  Future<void> addMotorbike(MotorModel motorbike) async {
    // await _firestore.collection('motor').doc().set(motorbike.toMap());
    var doc = await _firestore.collection('motor').add(motorbike.toMap());
    await _firestore.collection('motor').doc(doc.id).update({
      'motorID': doc.id,
    });
  }

  Future<void> deleteMotor(String motorID) async {
    await _firestore.collection('motor').doc(motorID).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMotorbike() {
    return _firestore.collection('motor').snapshots();
  }

  Stream<MotorModel> getDetailMotor(String motorID) {
    return _firestore
        .collection('motor')
        .doc(motorID)
        .snapshots()
        .map((event) => MotorModel.fromFirestore(event));
  }

  //getdetailmotor future
  Future<MotorModel> getDetailMotorFuture(String motorID) async {
    DocumentSnapshot doc =
        await _firestore.collection('motor').doc(motorID).get();
    return MotorModel.fromFirestore(doc);
  }

  //stream motor by merek
  Stream<QuerySnapshot<Map<String, dynamic>>> getMotorByMerek(String merek) {
    return _firestore
        .collection('motor')
        .where('merek', isEqualTo: merek)
        .snapshots();
  }

  Stream<List<MotorModel>> getMotorSearchStream(String namaMotor) {
    return _firestore
        .collection('motor')
        .orderBy('namaMotor')
        .startAt([namaMotor.capitalize])
        .endAt(['$namaMotor\uf8ff'])
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => MotorModel.fromFirestore(doc)).toList());
  }

  //update motor
  Future<void> updateMotor(MotorModel motor) async {
    await _firestore
        .collection('motor')
        .doc(motor.motorID)
        .update(motor.toMap());
  }

  //update motor without gamvarUrl
  Future<void> updateMotorTanpaGambarUrl(MotorModel motor) async {
    await _firestore.collection('motor').doc(motor.motorID).update({
      'namaMotor': motor.namaMotor,
      'merek': motor.merek,
      'jumlah': motor.jumlah,
      'harga': motor.harga,
      'cc': motor.cc,
      'status': motor.status,
    });
  }
}
