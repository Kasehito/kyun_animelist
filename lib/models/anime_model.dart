import 'image_model.dart';

class AnimeModel {
  String title;
  Map<String, ImageModel> images;
  int? rank;
  bool? airing;
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
    this.rank,
    this.synopsis,
    this.rating,
    this.duration,
    this.airing,
    required this.genre,
    this.score,
    required this.type,
    this.status,
    this.episode,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      rank: json['rank'] != null ? int.tryParse(json['rank'].toString()) : null,
      genre: (json['genres'] as List)
          .map((genre) => genre['name'].toString())
          .toList(),
      title: json['title'].toString(),
      images: {
        'jpg': ImageModel.fromJson(json['images']['jpg']),
        'webp': ImageModel.fromJson(json['images']['webp']),
      },
      synopsis: json['synopsis']?.toString(),
      duration: json['duration']?.toString(),
      airing: json['airing'] ?? false,
      rating: json['rating']?.toString(),
      type: json['type'].toString(),
      status: json['status']?.toString(),
      episode: json['episodes']?.toString(),
      score: json['score']?.toString(),
    );
  }
}
