import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/anime_model.dart';
import 'dart:async';

class SearchingController extends GetxController {
  final searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  final RxList<AnimeModel> searchResults = <AnimeModel>[].obs;
  final RxBool isLoading = false.obs;
  Timer? _debounceTimer;

  Future<void> searchAnime(String query) async {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      try {
        isLoading.value = true;
        final response = await _apiService.searchAnime(query);
        searchResults.value = response;
      } catch (e) {
        print('Error searching anime: $e');
      } finally {
        isLoading.value = false;
      }
    });
  }

  void clearSearch() {
    searchController.clear();
    searchResults.clear();
  }
}
