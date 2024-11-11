import 'package:flutter/material.dart';
import '../component/my_top_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: TabBar(
                isScrollable: true,
                indicator: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[600],
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                tabAlignment: TabAlignment.start,
                labelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[800],
                dividerColor: Colors.transparent,
                tabs: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Top Anime'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Airing'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Upcoming'),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Popular'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MyTopList(),
                  _buildComingSoonTab('Airing Anime'),
                  _buildComingSoonTab('Upcoming Anime'),
                  _buildComingSoonTab('Popular Anime'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComingSoonTab(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month,
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
