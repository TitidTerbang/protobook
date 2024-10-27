import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UserScreen extends StatelessWidget {
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil User'),
      ),
      body: Obx(() => Center(
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
            SizedBox(height: 10), // gap antara email dan username
            Text(
              userController.appUser.value.email ?? 'Email tidak tersedia',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      )),
    );
  }
}