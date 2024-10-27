import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserController extends GetxController {
  final appUser = AppUser(
      name: 'Nama User',
      profilePicture: 'https://via.placeholder.com/150')
      .obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    loadProfilePicture();
    _loadUserData();
  }

  void _loadUserData() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      appUser.update((val) {
        val?.email = firebaseUser.email;
      });
    }
    }

  Future<void> changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      appUser.update((val) {
        val?.profilePicture = image.path;
      });
      saveProfilePicture(image.path);
    }
  }

  Future<void> saveProfilePicture(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePicture', path);
  }

  Future<void> loadProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString('profilePicture');
    if (path != null) {
      appUser.update((val) {
        val?.profilePicture = path;
      });
    }
  }
}
