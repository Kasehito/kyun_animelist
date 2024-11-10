import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/anime_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimeController animeController = Get.put(AnimeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime List'),
      ),
      body: Obx(() {
        if (animeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (animeController.animeList.isEmpty) {
          return const Center(child: Text('No data'));
        }

        return ListView.builder(
          itemCount: animeController.animeList.length,
          itemBuilder: (context, index) {
            final anime = animeController.animeList[index];

            return Card(
              child: ListTile(
                leading: Image.network(
                  anime.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(anime.title),
                subtitle:
                    Text('Score: ${anime.score} • Episodes: ${anime.episode}'),
              ),
            );
          },
        );
      }),
    );
  }
}
