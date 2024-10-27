import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'views/home_screen.dart';
import 'views/user_screen.dart';
import 'views/bookDetail_screen.dart';
import 'views/populer_screen.dart';
import 'views/auth/signin_screen.dart';
import 'views/auth/signup_screen.dart';
import 'controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform,
  );
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController =
      Get.find();

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
