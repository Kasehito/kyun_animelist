import 'package:get/get.dart';

class ProfileController extends GetxController {
  final username = 'johndoe'.obs;
  final fullName = 'John Doe'.obs;
  final email = 'john@example.com'.obs;
  final bio = 'Anime Lover'.obs;
  
  final watchingCount = 23.obs;
  final completedCount = 147.obs;
  final planToWatchCount = 89.obs;

  void updateProfile({
    required String fullName,
    required String username,
    required String bio,
  }) {
    this.fullName.value = fullName;
    this.username.value = username;
    this.bio.value = bio;
  }

  void logout() {
    Get.offAllNamed('/login');
  }
} 