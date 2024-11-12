import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyun_animelist/component/my_card.dart';
import '../component/my_searchfield.dart';
import '../controllers/searching_controller.dart';

import '../pages/subpages/detail.dart';

class Search extends StatelessWidget {
  Search({super.key});
  final SearchingController controller = Get.put(SearchingController());

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
                autofocus: true,
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchResults.isEmpty) {
                  return const Center(
                    child: Text('No results found'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final anime = controller.searchResults[index];
                    return AnimeCard(
                      imageUrl: anime.images['jpg']?.largeImageUrl ?? '',
                      score: anime.score ?? 'N/A',
                      title: anime.title,
                      genres: anime.genre,
                      showRank: false,
                      episode: anime.episode ?? '',
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
