import 'package:flutter/material.dart';
import 'home-page/my_top_list.dart';
import '../pages/navigation/tabnav.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabNav(
        tabs: const ['Top Anime', 'Airing', 'Upcoming', 'Popular'],
        views: [
          const MyTopList(),
          _buildComingSoonTab('Airing Anime'),
          _buildComingSoonTab('Upcoming Anime'),
          _buildComingSoonTab('Popular Anime'),
        ],
      ),
    );
  }

  Widget _buildComingSoonTab(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.watch_later_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
