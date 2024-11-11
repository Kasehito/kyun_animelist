import 'package:flutter/material.dart';
import '../component/my_searchfield.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MySearchField(
                hintText: 'Search anime...',
                icon: Icons.search,
                onChanged: (value) {
                  // TODO: Implement search logic
                },
              ),
            ),
            // Results will be shown here
            Expanded(
              child: Center(
                child: Text(
                  'Start searching for anime!',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
