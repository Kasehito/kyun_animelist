import 'package:get/get.dart';
import '../models/anime_model.dart';
import 'dart:convert';

class ApiService extends GetConnect {
  @override
  final String baseUrl = 'https://api.jikan.moe/v4/';

  Future<List<AnimeModel>> fetchAnime(int page, int limit) async {
    final response = await get('${baseUrl}top/anime?page=$page&limit=$limit');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> animeData = data['data'];
      return animeData.map((item) => AnimeModel.fromJson(item)).toList();
    }
    throw Exception('Failed to load anime ${response.statusCode}');
  }
}
