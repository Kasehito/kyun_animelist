import 'package:get/get.dart';
import '../api/api_service.dart';
import '../models/anime_model.dart';

enum AnimeListType {
  top,
  // recommend,
  // Bisa ditambah tipe lain seperti: upcoming, airing, dll
}

class AnimeController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final AnimeListType type;
  int page = 1;
  var isLoading = true.obs;
  var animeList = <AnimeModel>[].obs;

  AnimeController({this.type = AnimeListType.top}); // Default ke top anime

  @override
  void onInit() {
    super.onInit();
    getAnime();
  }

  Future<void> getAnime() async {
    try {
      List<AnimeModel> response;
      
      switch (type) {
        case AnimeListType.top:
          response = await _apiService.fetchTopAnime(page);
          break;
        // case AnimeListType.recommend:
        //   response = await _apiService.fetchRecommendAnime(page);
        //   break;
        default:
          response = await _apiService.fetchTopAnime(page);
      }
      
      animeList.addAll(response);
      page++;
    } catch (e) {
      print('Error fetching ${type.toString()}: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    page = 1;
    isLoading.value = true;
    animeList.clear();
    await getAnime();
    isLoading.value = false;
  }
}
