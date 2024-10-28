import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';

class UserScreen extends GetView<AuthController> {
  final userController = Get.put(UserController());
  final bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil User'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              controller.signOut();
            },
          ),
        ],
      ),
      body: Obx(() => SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    userController.changeProfilePicture();
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                    userController.appUser.value.profilePicture.contains('http')
                        ? NetworkImage(userController.appUser.value.profilePicture)
                        : FileImage(File(userController.appUser.value.profilePicture))
                    as ImageProvider,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  userController.appUser.value.name,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10),
                Text(
                  userController.appUser.value.email ?? 'Email tidak tersedia',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bio',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _showEditBioDialog(context),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          userController.appUser.value.bio ?? 'Belum ada bio',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _showEditBioDialog(BuildContext context) {
    bioController.text = userController.appUser.value.bio ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Bio'),
        content: TextField(
          controller: bioController,
          decoration: InputDecoration(
            hintText: 'Tulis bio Anda di sini',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              await userController.updateBio(bioController.text);
              Navigator.pop(context);
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }
}
