import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isLoggedIn = false.obs;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? user) {
      isLoggedIn.value = user != null;
    });
  }

  Future<void> signIn() async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      isLoggedIn.value = true;
      Get.offNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.');
      } else {
        Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
      }
    } finally {
      isLoading.value = false;
        Get.snackbar('Success', 'Sign in successful.');
      String? token = await FirebaseMessaging.instance.getToken();
      print('FCM Token: $token');
    }
  }

  Future<void> signUp() async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      isLoggedIn.value = true;
      Get.offNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      } else {
        Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
      }
    } finally {
      isLoading.value = false;
    }
  }


  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      isLoggedIn.value = false;
      Get.offAllNamed('/signIn');
      Get.snackbar('Success', 'Sign out successful.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out.');
    }
  }
}