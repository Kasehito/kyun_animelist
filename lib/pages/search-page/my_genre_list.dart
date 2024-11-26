import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/my_anime_card.dart';
import '../../controllers/genre_controller.dart';
import '../../component/my_genre_card.dart';
import '../subpages/detail.dart';

class MyGenreList extends StatelessWidget {
  const MyGenreList({super.key});

  @override
  Widget build(BuildContext context) {
    final GenreController genreController = Get.find<GenreController>();

    return Column(
      children: [
        SizedBox(
          height: 80,
          child: Obx(() {
            if (genreController.isLoadingAnime.value &&
                genreController.animeList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              key: const PageStorageKey<String>('genreList'),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: genreController.genres.length,
              itemBuilder: (context, index) {
                final genre = genreController.genres[index];
                return Obx(() => KeyedSubtree(
                  key: ValueKey(genre.malId),
                  child: MyGenreCard(
                    genre: genre,
                    isSelected:
                        genreController.selectedGenreId.value == genre.malId,
                    onTap: () => genreController.selectGenre(genre.malId),
                  ),
                ));
              },
            );
          }),
        ),
  
        Expanded(
          child: Obx(() {
            if (genreController.isLoadingAnime.value &&
                genreController.animeList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (genreController.animeList.isEmpty) {
              return const Center(child: Text('No anime found for this genre'));
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!genreController.isLoadingAnime.value &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  genreController.getAnimeByGenre();
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () => genreController.refreshData(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: genreController.animeList.length,
                  itemBuilder: (context, index) {
                    final anime = genreController.animeList[index];
                    return AnimeCard(
                      imageUrl: anime.images['jpg']?.largeImageUrl ?? '',
                      score: anime.score?.toString() ?? 'N/A',
                      title: anime.title,
                      genres: anime.genres,
                      type: anime.type,
                      episode: anime.episodes ?? '',
                      onTap: () => Get.to(() => Detail(anime: anime)),
                    );
                  },
                ),
              ),
            );
          }),
        ),
        Obx(() => genreController.isLoadingAnime.value
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : const SizedBox()),
      ],
    );
  }
}
