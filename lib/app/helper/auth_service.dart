import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import 'firestore_service.dart';

class AuthService extends GetxController {
  static AuthService get to => Get.find();
  FirebaseAuth _auth = FirebaseAuth.instance;
  var user = Rx<User?>(null);
  final FirestoreService _firestoreController = Get.put(FirestoreService());

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  @override
  void onReady() {
    super.onReady();
    user.bindStream(_auth.userChanges());
    user = Rx<User?>(_auth.currentUser);
  }

  Future<void> register(
      String name, String email, String phone, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? newUser = userCredential.user;

      if (newUser != null) {
        UserModel userModel = UserModel(
          userID: newUser.uid,
          name: name,
          email: email,
          phone: phone,
          rentalHistory: [],
        );
        await _firestoreController.addUser(userModel);
        Get.snackbar('Success', 'Akun berhasil di buat',
            colorText: Colors.white, backgroundColor: Colors.green);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Login Berhasil',
          colorText: Colors.white, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
