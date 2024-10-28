import 'package:firebase_messaging/firebase_messaging.dart';

class Announcement {
  final String title;
  final String body;

  Announcement({required this.title, required this.body});

  factory Announcement.fromRemoteMessage(RemoteMessage message) {
    return Announcement(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
    );
  }


  //tambahkan fungsi toJson() untuk menyimpan data ke local storage/database


  Map<String, dynamic> toJson() => {
    'title': title,
    'body': body,
  };



  //tambahkan fungsi fromJson() untuk membaca data dari local storage/database
  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    title: json['title'] ,
    body: json['body'],


  );


}