import 'package:get/get.dart';
import '../models/anime_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService extends GetConnect {
  @override
  final String baseUrl = 'https://api.jikan.moe/v4';
  final String authBaseUrl = 'https://mediadwi.com/api/latihan';

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

  Future<Map<String, dynamic>> registerUser({
    required String username,
    required String password,
    required String fullName,
    required String email,
  }) async {
    final Uri url = Uri.parse('$authBaseUrl/register-user');
    
    // Menggunakan POST method dengan form data
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
        'full_name': fullName,
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to register user ${response.statusCode}');
  }

  Future<Map<String, dynamic>> loginUser({
    required String username,
    required String password,
  }) async {
    final Uri url = Uri.parse('$authBaseUrl/login');
    
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to login ${response.statusCode}');
  }
}
