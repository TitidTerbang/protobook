import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/user.dart';

class UserController extends GetxController {
  final user = User(
      name: 'Nama User',
      profilePicture: 'https://via.placeholder.com/150')
      .obs;

  Future<void> changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      user.update((val) {
        val?.profilePicture = image.path;
      });
    }
  }
}