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

  Future<List<AnimeModel>> searchAnime(String query) async {
    final response = await http
        .get(Uri.parse('$baseUrl/anime?q=${Uri.encodeComponent(query)}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> searchResults = data['data'];
      return searchResults.map((item) => AnimeModel.fromJson(item)).toList();
    }
    throw Exception('Failed to search anime ${response.statusCode}');
  }

  Future<List<AnimeModel>> fetchAnimeByGenre(int genreId, int page) async {
    final response = await http.get(
      Uri.parse('$baseUrl/anime?genres=$genreId&page=$page')
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> animeData = data['data'];
      return animeData.map((item) => AnimeModel.fromJson(item)).toList();
    }
    throw Exception('Failed to load anime by genre ${response.statusCode}');
  }

  Future<List<Map<String, dynamic>>> fetchGenres() async {
    final response = await http.get(Uri.parse('$baseUrl/genres/anime'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['data']);
    }
    throw Exception('Failed to load genres ${response.statusCode}');
  }
}
