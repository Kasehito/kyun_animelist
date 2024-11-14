class GenreModel {
  final int malId;
  final String name;
  final int? count;
  final String? url;

  GenreModel({
    required this.malId,
    required this.name,
    this.count,
    this.url,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      malId: json['mal_id'],
      name: json['name'],
      count: json['count'],
      url: json['url'],
    );
  }
}
