import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kyun_animelist/api/auth_service.dart';


class LoginController extends GetxController {
  final AuthService authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  void login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await authService.signInWithEmailPassword(email, password);
      // Navigasi sekarang dikelola oleh AuthGate, jadi tidak perlu Get.offAllNamed('/bottomnav') di sini.
      Get.snackbar('Success', 'Login successful!');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
