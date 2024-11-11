import 'package:flutter/material.dart';

import 'pages/bottomnav.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottomNav(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      title: 'Kyun Anime List',
      initialRoute: '/bottomnav',
      getPages: [
        GetPage(name: '/bottomnav', page: () => const BottomNav()),
      ],
    );
  }
}
