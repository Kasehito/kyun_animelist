import 'image_model.dart';

class AnimeModel {
  String title;
  Map<String, ImageModel> images;
  int rank;
  String? synopsis;
  String? rating;
  String? duration;
  List<String> genre;
  String? score;
  String type;
  String? status;
  String? episode;

  AnimeModel({
    required this.title,
    required this.images,
    required this.rank,
    required this.synopsis,
    required this.rating,
    required this.duration,
    required this.genre,
    required this.score,
    required this.type,
    required this.status,
    required this.episode,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      rank: int.parse(json['rank'].toString()),
      genre: (json['genres'] as List)
          .map((genre) => genre['name'].toString())
          .toList(),
      title: json['title'].toString(),
      images: {
        'jpg': ImageModel.fromJson(json['images']['jpg']),
        'webp': ImageModel.fromJson(json['images']['webp']),
      },
      synopsis: json['synopsis'].toString(),
      duration: json['duration'].toString(),
      rating: json['rating'].toString(),
      type: json['type'].toString(),
      status: json['status'].toString(),
      episode: json['episodes'].toString(),
      score: json['score'].toString(),
    );
  }
}
