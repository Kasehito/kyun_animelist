import 'package:flutter/material.dart';
import '../../../models/anime_model.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, required this.anime});

  final AnimeModel anime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image Section
            Stack(
              children: [
                // Image
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(anime.images['jpg']?.largeImageUrl ??
                          anime.images['webp']?.largeImageUrl ??
                          ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient overlay
                  foregroundDecoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                      ],
                      stops: [0.6, 1.0],
                    ),
                  ),
                ),

                // Back Button
                Positioned(
                  top: 40,
                  left: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                // Title at bottom
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        anime.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber[400], size: 20),
                          const SizedBox(width: 4),
                          Text(
                            anime.score?.toString() ?? 'N/A',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.movie, color: Colors.blue[200], size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${anime.episodes ?? 'N/A'} Episodes',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Cards Row 1
                  Row(
                    children: [
                      _buildInfoCard(
                        icon: Icons.timer,
                        label: 'Duration',
                        value: anime.duration ?? 'Unknown',
                      ),
                      const SizedBox(width: 12),
                      _buildInfoCard(
                        icon: Icons.live_tv,
                        label: 'Status',
                        value: anime.status ?? 'Unknown',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Info Cards Row 2
                  Row(
                    children: [
                      _buildInfoCard(
                        icon: Icons.calendar_today,
                        label: 'Year',
                        value: anime.year?.toString() ?? 'Unknown',
                      ),
                      const SizedBox(width: 12),
                      _buildInfoCard(
                        icon: Icons.remove_red_eye,
                        label: 'Rating',
                        value: anime.rating ?? 'Unknown',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Alternative Titles
                  if (anime.titleEnglish != null ||
                      anime.titleJapanese != null) ...[
                    _buildSectionTitle('Alternative Titles'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (anime.titleEnglish != null)
                            _buildTitleInfo('English', anime.titleEnglish!),
                          if (anime.titleJapanese != null) ...[
                            if (anime.titleEnglish != null)
                              const SizedBox(height: 8),
                            _buildTitleInfo('Japanese', anime.titleJapanese!),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Synopsis
                  _buildSectionTitle('Synopsis'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      anime.synopsis ?? 'No synopsis available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Information
                  _buildSectionTitle('Information'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow('Type', anime.type),
                        _buildInfoRow('Episodes', anime.episodes ?? 'Unknown'),
                        _buildInfoRow('Status', anime.status ?? 'Unknown'),
                        _buildInfoRow(
                            'Aired',
                            anime.airing == true
                                ? 'Currently Airing'
                                : 'Finished'),
                        if (anime.duration != null)
                          _buildInfoRow('Duration', anime.duration!),
                        if (anime.rating != null)
                          _buildInfoRow('Rating', anime.rating!),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Studios & Producers
                  if (anime.studios != null || anime.producers != null) ...[
                    _buildSectionTitle('Studios & Producers'),
                    const SizedBox(height: 8),
                    if (anime.studios != null && anime.studios!.isNotEmpty)
                      _buildChipsSection(
                          'Studios', anime.studios!, Colors.purple),
                    if (anime.producers != null &&
                        anime.producers!.isNotEmpty) ...[
                      if (anime.studios != null) const SizedBox(height: 12),
                      _buildChipsSection(
                          'Producers', anime.producers!, Colors.teal),
                    ],
                    const SizedBox(height: 24),
                  ],

                  // Genres
                  if (anime.genres.isNotEmpty) ...[
                    _buildSectionTitle('Genres'),
                    const SizedBox(height: 8),
                    _buildChipsSection('', anime.genres, Colors.blue,
                        showLabel: false),
                  ],
                  const SizedBox(height: 24),

                  // Themes
                  if (anime.themes != null && anime.themes!.isNotEmpty) ...[
                    _buildSectionTitle('Themes'),
                    const SizedBox(height: 8),
                    _buildChipsSection('', anime.themes!, Colors.orange,
                        showLabel: false),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTitleInfo(String language, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            language,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipsSection(
      String label, List<String> items, MaterialColor color,
      {bool showLabel = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel && label.isNotEmpty) ...[
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items
              .map((item) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: color[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: color[200]!),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(color: color[800]),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue[700], size: 20),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
