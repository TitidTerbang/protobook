import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_screen.dart';
import 'views/user_screen.dart'; // Tambahkan import ini

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Book App',
      initialRoute: '/', // Tentukan initial route
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()), // Konfigurasi route untuk home
        GetPage(name: '/user', page: () => UserScreen()), // Konfigurasi route untuk user
      ],
    );
  }
}