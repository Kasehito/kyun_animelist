class AnimeModel {
  String title;
  String image;
  String genre;
  String score;
  String type;
  String status;
  String episode;

  AnimeModel({
    required this.title,
    required this.image,
    required this.genre,
    required this.score,
    required this.type,
    required this.status,
    required this.episode,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      genre: json['genres'][0]['name'].toString(),
      title: json['title'].toString(),
      image: json['images']['jpg']['image_url'].toString(),
      type: json['type'].toString(),
      status: json['status'].toString(),
      episode: json['episodes'].toString(),
      score: json['score'].toString(),
    );
  }
}
