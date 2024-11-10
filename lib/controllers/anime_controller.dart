import 'package:get/get.dart';
import '../api/api_service.dart';
import '../models/anime_model.dart';

class AnimeController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  int page = 1;
  var isLoading = true.obs;
  final int _limit = 15;
  var animeList = <AnimeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAnime();
  }

  Future<void> getAnime() async {
    try {
      isLoading.value = true;
      var response = await _apiService.fetchAnime(page, _limit);
      if (response.length < _limit) {
        isLoading.value = false;
      }
      animeList.addAll(response);
      page++;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future refresh() async {
    page = 1;
    isLoading.value = true;
    animeList.clear();
    await getAnime();
    isLoading.value = false;
  }
}
