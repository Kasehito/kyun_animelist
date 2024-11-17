import 'package:flutter/material.dart';

import 'pages/navigation/bottomnav.dart';
import 'package:get/get.dart';
import 'pages/auth/loginpage.dart';
import 'pages/auth/signuppage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      title: 'Kyun Anime List',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/bottomnav', page: () => const BottomNav()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
      ],
    );
  }
}
