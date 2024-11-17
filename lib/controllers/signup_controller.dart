import 'package:get/get.dart';
import '../api/api_service.dart';

class SignUpController extends GetxController {
  final ApiService _apiService = ApiService();
  
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> registerUser({
    required String username,
    required String password,
    required String fullName,
    required String email,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.registerUser(
        username: username,
        password: password,
        fullName: fullName,
        email: email,
      );

      if (response['status'] == true) {
        Get.snackbar('Success', 'Registration successful!');
        Get.offAllNamed('/login');
      } else {
        errorMessage.value = response['message'] ?? 'Registration failed';
        Get.snackbar('Error', errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
} 