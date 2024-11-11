import 'package:get/get.dart';
import '../models/anime_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService extends GetConnect {
  @override
  final String baseUrl = 'https://api.jikan.moe/v4';

  Future<List<AnimeModel>> fetchTopAnime(
    int page,
  ) async {
    final response = await http.get(Uri.parse('$baseUrl/top/anime?page=$page'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> topAnimeData = data['data'];
      return topAnimeData.map((item) => AnimeModel.fromJson(item)).toList();
    }
    throw Exception('Failed to load anime ${response.statusCode}');
  }

  Future<List<AnimeModel>> fetchRecommendAnime(
    int page,
  ) async {
    final response = await http.get(Uri.parse('$baseUrl/recommendations/anime?page=$page'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> recommendAnimeData = data['data'];
      return recommendAnimeData.map((item) => AnimeModel.fromJson(item)).toList();
    }
    throw Exception('Failed to load anime ${response.statusCode}');
  }
}
