import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kyun_animelist/api/auth_service.dart';

class SignUpController extends GetxController {
  final AuthService authService = AuthService();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> registerUser() async {
    final username = usernameController.text;
    final password = passwordController.text;
    final email = emailController.text;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await authService.signUpWithEmailPassword(email, password, username);

      Get.snackbar('Success', 'Registration successful!');
      Get.offAllNamed('/login');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
