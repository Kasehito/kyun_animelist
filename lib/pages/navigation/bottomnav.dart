import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/bottom_nav_controller.dart';
import '../home.dart';
import '../search.dart';
import '../profile.dart';
import '../season.dart';
import '../mylist.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavController());

    final menus = [
      const Home(),
      const MyList(),
      Search(),
      const Season(),
      const Profile(),
    ];
    return Scaffold(
      body: Obx(() => Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                'KyunAnimeList',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Obx(() {
                  final isSearchPage = Get.currentRoute == '/search' ||
                      controller.selectedIndex.value == 2;

                  return isSearchPage
                      ? const SizedBox()
                      : IconButton(
                          icon: const Icon(Icons.search, color: Colors.black87),
                          onPressed: () {
                            controller.changeIndex(2);
                          },
                        );
                }),
              ],
            ),
            body: Center(
              child: menus.elementAt(controller.selectedIndex.value),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: (index) => controller.changeIndex(index),
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt),
                  label: 'My List',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Season',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          )),
    );
  }
}
