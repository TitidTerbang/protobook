import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Tambahkan import Firebase Storage
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../models/user.dart';

class UserController extends GetxController {
  final appUser = AppUser(
    name: 'Nama User',
    profilePicture: 'https://via.placeholder.com/150',
    bio: '',
  ).obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    await _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot userData = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (userData.exists) {
        Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
        appUser.update((val) {
          if (val != null) {
            val.email = firebaseUser.email;
            val.bio = data['bio'];
            if (data['name'] != null) val.name = data['name'];
            if (data['profilePicture'] != null) val.profilePicture = data['profilePicture'];
          }
        });
      } else {
        // Jika user baru, tambahkan data default ke Firestore
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'email': firebaseUser.email,
          'bio': '',
          'name': appUser.value.name,
          'profilePicture': appUser.value.profilePicture,
        });
      }
    }
  }

  Future<void> updateBio(String newBio) async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      await _firestore.collection('users').doc(firebaseUser.uid).update({
        'bio': newBio,
      });
      appUser.update((val) {
        if (val != null) {
          val.bio = newBio;
        }
      });
    }
  }

  Future<void> changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      try {
        String userId = _auth.currentUser!.uid;

        // Upload gambar ke Firebase Storage
        TaskSnapshot uploadTask = await _storage
            .ref('profile_pictures/$userId.jpg')
            .putFile(imageFile);

        // Ambil URL gambar dari Firebase Storage
        String downloadUrl = await uploadTask.ref.getDownloadURL();

        // Simpan URL gambar di Firestore
        await _firestore.collection('users').doc(userId).update({
          'profilePicture': downloadUrl,
        });

        // Update gambar di appUser
        appUser.update((val) {
          if (val != null) {
            val.profilePicture = downloadUrl;
          }
        });
      } catch (e) {
        print("Error uploading profile picture: $e");
      }
    }
  }

  Future<void> updateName(String newName) async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      await _firestore.collection('users').doc(firebaseUser.uid).update({
        'name': newName,
      });
      appUser.update((val) {
        if (val != null) {
          val.name = newName;
        }
      });
    }
  }

  Future<void> refreshUserData() async {
    await _loadUserData();
  }
}
