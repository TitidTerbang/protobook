import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proto_book/controllers/auth_controller.dart';


class SignInScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              SizedBox(height: 24),
              Obx(() => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: controller.signIn,
                child: Text('Sign In'),
              )),
              TextButton(
                  onPressed: () => Get.toNamed('/signUp'),
                  child: Text('Don\'t have account? Sign Up'))
            ],
          ),
        ),
      ),
    );
  }
}