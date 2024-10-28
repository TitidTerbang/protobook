import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proto_book/controllers/announcement_controller.dart';
import 'package:proto_book/models/announcement.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//inisialisasi notifikasi plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  void initState() {
    super.initState();
    // Inisialisasi listener untuk notifikasi foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              // Pastikan ID channel sama dengan yang di main.dart
              'High Importance Notifications', // Nama channel
              channelDescription:
                  'This channel is used for important notifications.',
              icon: 'launch_background', // Ganti dengan icon aplikasi Anda
            ),
          ),
        );
        // Tambahkan logika untuk memperbarui UI announcement_screen di sini
        final announcementController = Get.find<AnnouncementController>();
        announcementController.addAnnouncementFromRemoteMessage(message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final announcementController = Get.find<AnnouncementController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengumuman'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: announcementController.announcements.length,
          itemBuilder: (context, index) {
            Announcement announcement =
                announcementController.announcements[index];
            return ListTile(
              title: Text(announcement.title),
              subtitle: Text(announcement.body),
            );
          },
        ),
      ),
    );
  }
}
