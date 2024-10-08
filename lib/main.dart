import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_screen.dart';
import 'views/user_screen.dart';
import 'views/bookDetail_screen.dart'; // Pastikan Anda mengimport BookDetailScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Book App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/user', page: () => UserScreen()),
        GetPage(name: '/bookDetail', page: () => BookDetailScreen()),
      ], // Hanya satu tanda kurung siku di sini
    );
  }
}