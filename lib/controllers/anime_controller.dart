import 'package:get/get.dart';
import '../api/api_service.dart';
import '../models/anime_model.dart';

class AnimeController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  int page = 1;
  var isLoading = true.obs;
  var animeList = <AnimeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAnime();
  }

  Future<void> getAnime() async {
    try {
      List<AnimeModel> response = await _apiService.fetchTopAnime(page);
      animeList.addAll(response);
      page++;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future refreshData() async {
    page = 1;
    isLoading.value = true;
    animeList.clear();
    await getAnime();
    isLoading.value = false;
  }
}
