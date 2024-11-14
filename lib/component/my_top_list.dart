import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyun_animelist/component/my_anime_card.dart';
import '../../controllers/anime_controller.dart';
import '../../pages/subpages/detail.dart';  

class MyTopList extends StatelessWidget {
  const MyTopList({super.key});

  List<Color> _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return [Colors.amber[100]!, Colors.amber[900]!]; // Gold
      case 2:
        return [Colors.grey[200]!, Colors.grey[800]!]; // Silver
      case 3:
        return [Colors.orange[100]!, Colors.orange[900]!]; // Bronze
      default:
        return [Colors.blue[100]!, Colors.blue[900]!]; // Default blue
    }
  }

  @override
  Widget build(BuildContext context) {
    final AnimeController animeController = Get.put(AnimeController());
    return Obx(() {
      if (animeController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (animeController.animeList.isEmpty) {
        return const Center(child: Text('No data'));
      }

      return RefreshIndicator(
        onRefresh: () => animeController.refreshData(),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: animeController.animeList.length + 1,
          itemBuilder: (context, index) {
            if (index == animeController.animeList.length) {
              if (!animeController.isLoading.value) {
                animeController.getAnime();
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: animeController.isLoading.value
                      ? const CircularProgressIndicator()
                      : const SizedBox(),
                ),
              );
            }

            final anime = animeController.animeList[index];

            return AnimeCard(
              imageUrl: anime.images['jpg']?.largeImageUrl ?? '',
              score: anime.score?.toString() ?? 'N/A',
              rank: anime.rank,
              title: anime.title,
              genres: anime.genres,
              type: anime.type,
              episode: anime.episodes ?? '',
              getRankColor: _getRankColor,
              onTap: () => Get.to(() => Detail(anime: anime)),
            );
          },
        ),
      );
    });
  }
}
