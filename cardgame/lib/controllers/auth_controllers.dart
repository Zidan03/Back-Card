import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login.dart';


class AuthController extends GetxController {
  FirebaseAuth _auth;
  SharedPreferences _prefs;

  // Constructor or initialization method
  AuthController({
    FirebaseAuth? auth, // Make it nullable to allow for null during testing
    SharedPreferences? prefs, // Make it nullable to allow for null during testing
  })  : _auth = auth ?? FirebaseAuth.instance,
        _prefs = prefs ?? Get.find<SharedPreferences>();

  FirebaseAuth get auth => _auth;
  SharedPreferences get prefs => _prefs;

  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Cek status login saat controller diinisialisasi
  }
  Future<void> checkLoginStatus() async {
    isLoggedIn.value = _prefs.containsKey('user_token');
  }


  Future<void> registerUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar('Success', 'Registration successful',
          backgroundColor: Colors.white);
      Get.off(LoginPage()); //Navigate ke Login Page
    } catch (error) {
      Get.snackbar('Error', 'Registration failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _prefs.setString('user_token', _auth.currentUser!.uid); // Simpan token autentikasi
      Get.snackbar('Success', 'Login successful',
          backgroundColor: Colors.white);
      isLoggedIn.value = true; // Set status login menjadi true
      Get.offAllNamed('/home'); // Navigate ke HomePage dan hapus semua halaman sebelumnya
    } catch (error) {
      Get.snackbar('Error', 'Login failed: $error',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
  void logout() {
    _prefs.remove('user_token'); // Hapus token autentikasi dari penyimpanan
    isLoggedIn.value = false; // Set status login menjadi false
    _auth.signOut(); // Sign out dari Firebase Authentication
    Get.offAllNamed('/login'); // Navigate ke HomePage dan hapus semua halaman sebelumnya
  }
}
