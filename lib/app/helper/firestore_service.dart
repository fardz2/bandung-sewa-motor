import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
}
