import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyun_animelist/component/my_anime_card.dart';
import 'package:kyun_animelist/pages/search-page/my_genre_list.dart';
import '../component/my_searchfield.dart';
import '../controllers/searching_controller.dart';
import '../controllers/genre_controller.dart';

import '../pages/subpages/detail.dart';

class Search extends StatelessWidget {
  Search({super.key});
  final SearchingController controller = Get.put(SearchingController());
  final GenreController genreController = Get.put(GenreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MySearchField(
                hintText: 'Search anime...',
                icon: Icons.search,
                controller: controller.searchController,
                onChanged: controller.searchAnime,
                onClear: controller.clearSearch,
                autofocus: true,
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchResults.isEmpty) {
                  return const MyGenreList();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final anime = controller.searchResults[index];
                    return AnimeCard(
                      imageUrl: anime.images['jpg']?.largeImageUrl ?? '',
                      score: anime.score?.toString() ?? 'N/A',
                      title: anime.title,
                      genres: anime.genres,
                      showRank: false,
                      episode: anime.episodes ?? '',
                      type: anime.type,
                      onTap: () => Get.to(() => Detail(anime: anime)),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
