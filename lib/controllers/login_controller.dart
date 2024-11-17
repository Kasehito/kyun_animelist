import 'package:get/get.dart';
import '../api/api_service.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiService.loginUser(
        username: username,
        password: password,
      );

      if (response['status'] == true) {
        Get.snackbar('Success', 'Login successful!');
        Get.offAllNamed('/bottomnav');
      } else {
        errorMessage.value = response['message'] ?? 'Login failed';
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