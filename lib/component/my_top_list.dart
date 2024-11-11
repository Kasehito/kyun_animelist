import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/anime_controller.dart';
import '../pages/subpages/detail.dart';

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

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Get.to(() => Detail(anime: anime));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              anime.images['jpg']?.largeImageUrl ?? '',
                              width: 100,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text(
                                    anime.score ?? 'N/A',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getRankColor(anime.rank)[0],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '#${anime.rank}',
                                    style: TextStyle(
                                      color: _getRankColor(anime.rank)[1],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              anime.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: anime.genre
                                  .map((genre) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          genre,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.movie_outlined,
                                    size: 16, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(
                                  '${anime.type} • ${anime.episode} eps',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
