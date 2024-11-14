import 'image_model.dart';

class AnimeModel {
  bool? airing;
  int? malId;
  int? rank;
  int? year;
  String? titleJapanese;
  String? titleEnglish;
  List<String>? titleSynonyms;
  String title;
  String? synopsis;
  String? rating;
  String? duration;
  double? score;
  String type;
  String? status;
  String? episodes;
  List<String> genres;
  List<String>? themes;
  List<String>? studios;
  List<String>? producers;
  Map<String, ImageModel> images;
  String? season;
  int? favorites;
  int? popularity;

  AnimeModel({
    required this.title,
    required this.images,
    required this.type,
    required this.genres,
    this.malId,
    this.rank,
    this.titleJapanese,
    this.titleEnglish,
    this.titleSynonyms,
    this.synopsis,
    this.rating,
    this.duration,
    this.airing,
    this.score,
    this.status,
    this.episodes,
    this.year,
    this.themes,
    this.studios,
    this.producers,
    this.season,
    this.favorites,
    this.popularity,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      malId: json['mal_id'],
      rank: json['rank'],
      year: json['year'],
      genres: (json['genres'] as List?)
          ?.map((genre) => genre['name'].toString())
          .toList() ?? [],
      images: {
        'jpg': ImageModel.fromJson(json['images']['jpg']),
        'webp': ImageModel.fromJson(json['images']['webp']),
      },
      themes: json['themes'] != null
          ? (json['themes'] as List)
              .map((theme) => theme['name'].toString())
              .toList()
          : null,
      studios: json['studios'] != null
          ? (json['studios'] as List)
              .map((studio) => studio['name'].toString())
              .toList()
          : null,
      producers: json['producers'] != null
          ? (json['producers'] as List)
              .map((producer) => producer['name'].toString())
              .toList()
          : null,
      title: json['title'] ?? '',
      titleJapanese: json['title_japanese'],
      titleEnglish: json['title_english'],
      titleSynonyms: json['title_synonyms'] != null 
          ? List<String>.from(json['title_synonyms'])
          : null,
      synopsis: json['synopsis'],
      duration: json['duration'],
      airing: json['airing'] ?? false,
      rating: json['rating'],
      type: json['type'] ?? 'Unknown',
      status: json['status'],
      episodes: json['episodes']?.toString(),
      score: json['score'] != null ? double.tryParse(json['score'].toString()) : null,
      season: json['season'],
      favorites: json['favorites'],
      popularity: json['popularity'],
    );
  }
}
