import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'views/home_screen.dart';
import 'views/user_screen.dart';
import 'views/bookDetail_screen.dart';
import 'views/populer_screen.dart';
import 'views/auth/signin_screen.dart'; // Import halaman sign in
import 'views/auth/signup_screen.dart'; // Import halaman sign up
import 'controllers/auth_controller.dart'; // Import controller
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan binding diinisialisasi
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Gunakan konfigurasi Firebase Anda
  );
  Get.put(AuthController()); // Inisialisasi AuthController secara global
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController =
      Get.find(); // Ambil instance AuthController

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Book App',
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () =>
              authController.isLoggedIn.value ? HomeScreen() : SignInScreen(),
        ),
        // Arahkan ke home jika sudah login, kalau belum ke sign in
        GetPage(name: '/signIn', page: () => SignInScreen()),
        GetPage(name: '/signUp', page: () => SignUpScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/user', page: () => UserScreen()),
        GetPage(name: '/bookDetail', page: () => BookDetailScreen()),
        GetPage(name: '/popularBooks', page: () => PopularScreen()),
      ],
    );
  }
}
