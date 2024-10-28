import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:proto_book/models/announcement.dart';

class AnnouncementController extends GetxController {
  final RxList<Announcement> _announcements = <Announcement>[].obs;

  List<Announcement> get announcements => _announcements.value;

  void addAnnouncement(Announcement announcement) {
    _announcements.insert(0, announcement);
  }

  void addAnnouncementFromRemoteMessage(RemoteMessage message) {
    Announcement newAnnouncement = Announcement.fromRemoteMessage(message);

    addAnnouncement(newAnnouncement);
  }

  @override
  void onInit() {
    super.onInit();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        addAnnouncementFromRemoteMessage(message);
      }
    });
  }
}
