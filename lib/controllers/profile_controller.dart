import 'package:get/get.dart';

class ProfileController extends GetxController {
  final username = 'johndoe'.obs;
  final fullName = 'John Doe'.obs;
  final email = 'john@example.com'.obs;
  
  final watchingCount = 23.obs;
  final completedCount = 147.obs;
  final planToWatchCount = 89.obs;

  void logout() {
    Get.offAllNamed('/login');
  }
} 