import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proto_book/controllers/announcement_controller.dart'; // Import controller
import 'package:proto_book/views/announcement_screen.dart';
import 'package:proto_book/views/search_result_screen.dart';
import 'package:proto_book/views/speaker_screen.dart';
import 'firebase_options.dart';
import 'views/home_screen.dart';
import 'views/user_screen.dart';
import 'views/bookDetail_screen.dart';
import 'views/populer_screen.dart';
import 'views/auth/signin_screen.dart';
import 'views/auth/signup_screen.dart';
import 'controllers/auth_controller.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
  // Logika untuk menyimpan notifikasi ke local storage/database
  Get.find<AnnouncementController>().addAnnouncementFromRemoteMessage(message);
}

Future<void> requestMicrophonePermission() async {
  var status = await Permission.microphone.request();
  if (status.isGranted) {
    print("Microphone permission granted");
  } else if (status.isDenied) {
    print("Microphone permission denied");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestMicrophonePermission();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Request permission (penting!)
  await FirebaseMessaging.instance.requestPermission();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  // Inisialisasi controller
  Get.put(AuthController());
  Get.put(AnnouncementController()); // Inisialisasi controller

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.find();
  final AnnouncementController announcementController = Get.find();

  MyApp({super.key});

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
        GetPage(name: '/announcement', page: () => AnnouncementScreen()),
        GetPage(name: '/user', page: () => UserScreen()),
        GetPage(name: '/bookDetail', page: () => BookDetailScreen()),
        GetPage(name: '/popularBooks', page: () => PopularScreen()),
        GetPage(
          name: '/searchResults',
          page: () => SearchResultScreen(query: Get.parameters['query'] ?? ''),
        ),
        GetPage(name: '/speaker', page: () => SpeakerScreen()),
      ],
    );
  }
}
