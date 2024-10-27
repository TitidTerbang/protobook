import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserController extends GetxController {
  final user = User(
      name: 'Nama User',
      profilePicture: 'https://via.placeholder.com/150')
      .obs;

  @override
  void onInit() {
    super.onInit();
    loadProfilePicture(); // Load saat inisialisasi
  }

  Future<void> changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      user.update((val) {
        val?.profilePicture = image.path;
      });
      saveProfilePicture(image.path); // Simpan path ke local storage
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
      user.update((val) {
        val?.profilePicture = path;
      });
    }
  }
}