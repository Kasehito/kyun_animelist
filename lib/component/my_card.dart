import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const MyCard({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12),
          child: child,
        ),
      ),
    );
  }
}

// Add a specialized AnimeCard widget that uses MyCard
class AnimeCard extends StatelessWidget {
  final String imageUrl;
  final String? score;
  final int? rank;
  final String title;
  final List<String>? genres;
  final String? type;
  final String? episode;
  final VoidCallback onTap;
  final List<Color> Function(int)? getRankColor;
  final bool showScore;
  final bool showRank;
  final bool showGenres;
  final bool showTypeAndEpisode;

  const AnimeCard({
    super.key,
    required this.imageUrl,
    this.score,
    this.rank,
    required this.title,
    this.genres,
    this.type,
    this.episode,
    required this.onTap,
    this.getRankColor,
    this.showScore = true,
    this.showRank = true,
    this.showGenres = true,
    this.showTypeAndEpisode = true,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      margin: const EdgeInsets.only(bottom: 16),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              if (showScore && score != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildScoreWidget(),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showRank && rank != null)
                  Row(
                    children: [
                      _buildRankWidget(),
                      const SizedBox(width: 8),
                    ],
                  ),
                const SizedBox(height: 8),
                _buildTitleWidget(),
                if (showGenres && genres != null) ...[
                  const SizedBox(height: 8),
                  _buildGenresWidget(),
                ],
                if (showTypeAndEpisode && (type != null || episode != null)) ...[
                  const SizedBox(height: 8),
                  _buildTypeAndEpisodeWidget(),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildScoreWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, size: 16, color: Colors.amber),
          const SizedBox(width: 4),
          Text(
            score!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: getRankColor?.call(rank ?? 0)[0] ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '#$rank',
        style: TextStyle(
          color: getRankColor?.call(rank ?? 0)[1] ?? Colors.grey[800],
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildGenresWidget() {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: genres!.map((genre) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          genre,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[800],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildTypeAndEpisodeWidget() {
    return Row(
      children: [
        Icon(Icons.movie_outlined, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          [if (type != null) type, if (episode != null) '$episode eps']
              .join(' • '),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
