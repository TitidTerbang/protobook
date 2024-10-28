import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserController extends GetxController {
  final appUser = AppUser(
    name: 'Nama User',
    profilePicture: 'https://via.placeholder.com/150',
    bio: '',
  ).obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadProfilePicture();
    await _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      // Load data dari Firestore
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
        // Buat dokumen baru jika belum ada
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
      // Simpan path gambar ke SharedPreferences dulu
      await saveProfilePicture(image.path);

      appUser.update((val) {
        if (val != null) {
          val.profilePicture = image.path;
        }
      });

      // Update profile picture di Firestore
      User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        await _firestore.collection('users').doc(firebaseUser.uid).update({
          'profilePicture': image.path,
        });
      }
    }
  }

  // Method untuk menyimpan path gambar profil di SharedPreferences
  Future<void> saveProfilePicture(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePicture', path);
  }

  // Method untuk memuat gambar profil dari SharedPreferences
  Future<void> loadProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString('profilePicture');
    if (path != null) {
      appUser.update((val) {
        if (val != null) {
          val.profilePicture = path;
        }
      });
    }
  }

  // Method untuk update nama user
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

  // Method untuk mendapatkan data user terbaru dari Firestore
  Future<void> refreshUserData() async {
    await _loadUserData();
  }
}