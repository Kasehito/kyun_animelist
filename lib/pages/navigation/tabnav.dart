import 'package:flutter/material.dart';

class TabNav extends StatelessWidget {
  final List<String> tabs;
  final List<Widget> views;

  const TabNav({
    super.key,
    required this.tabs,
    required this.views,
  }) : assert(tabs.length == views.length);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
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
              tabs: tabs.map((tab) => Container(
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
                child: Text(tab),
              )).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: views,
            ),
          ),
        ],
      ),
    );
  }
}