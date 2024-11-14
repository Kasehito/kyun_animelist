import 'package:get/get.dart';
import '../api/api_service.dart';
import '../models/genre_model.dart';
import '../models/anime_model.dart';

class GenreController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());
  final RxList<GenreModel> genres = <GenreModel>[].obs;
  final RxList<AnimeModel> animeList = <AnimeModel>[].obs;
  final RxInt selectedGenreId = 0.obs;
  final RxBool isLoadingAnime = false.obs;
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    getGenres();
  }

  void updateSelectedGenre(int genreId) {
    selectedGenreId.value = genreId;
    update();
    loadAnimeData();
  }

  void loadAnimeData() {
    page = 1;
    animeList.clear();
    getAnimeByGenre();
  }

  Future<void> getGenres() async {
    try {
      final response = await _apiService.fetchGenres();
      genres.value = response.map((json) => GenreModel.fromJson(json)).toList();
      if (genres.isNotEmpty) {
        selectedGenreId.value = genres[0].malId;
        await getAnimeByGenre();
      }
    } catch (e) {
      print('Error fetching genres: $e');
    }
  }

  Future<void> getAnimeByGenre() async {
    try {
      if (selectedGenreId.value == 0) return;

      isLoadingAnime.value = true;
      final response =
          await _apiService.fetchAnimeByGenre(selectedGenreId.value, page);
      animeList.addAll(response);
      page++;
    } catch (e) {
      print('Error fetching anime by genre: $e');
    } finally {
      isLoadingAnime.value = false;
    }
  }

  Future<void> refreshData() async {
    page = 1;
    animeList.clear();
    await getAnimeByGenre();
  }

  @override
  void onClose() {
    animeList.clear();
    genres.clear();
    super.onClose();
  }

  void selectGenre(int genreId) {
    if (selectedGenreId.value == genreId) return;

    selectedGenreId.value = genreId;

    Future.microtask(() {
      page = 1;
      animeList.clear();
      getAnimeByGenre();
    });
  }
}
