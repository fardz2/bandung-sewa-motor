import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../routes/app_pages.dart';
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
        );
        await _firestoreController.addUser(userModel);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email sudah digunakan oleh akun lain.';
          break;
        case 'invalid-email':
          errorMessage = 'Alamat email tidak valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Operasi ini tidak diizinkan.';
          break;
        case 'weak-password':
          errorMessage = 'Kata sandi terlalu lemah.';
          break;
        default:
          errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
      }
      throw errorMessage;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Alamat email tidak valid.';
          break;
        case 'user-disabled':
          errorMessage = 'Pengguna ini telah dinonaktifkan.';
          break;
        case 'user-not-found':
          errorMessage = 'Pengguna dengan email ini tidak ditemukan.';
          break;
        case 'invalid-credential':
          errorMessage = 'Email atau Kata sandi salah.';
          break;
        default:
          errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
      }
      throw errorMessage;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.snackbar('Logout', 'Logout Berhasil',
          colorText: Colors.white, backgroundColor: Colors.red);
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      throw Exception('Gagal keluar. Silakan coba lagi.');
    }
  }

  Future<void> logoutReg() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
