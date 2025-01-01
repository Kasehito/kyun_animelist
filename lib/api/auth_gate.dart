import 'package:flutter/material.dart';
import 'package:kyun_animelist/pages/auth/loginpage.dart';
import 'package:kyun_animelist/pages/navigation/bottomnav.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_service.dart';

class AuthGate extends StatelessWidget {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final session = snapshot.data?.session;
        if (session != null && session.user != null) {
          return BottomNav(); // Ganti dengan halaman utama Anda
        } else {
          return LoginPage(); // Ganti dengan halaman login Anda
        }
      },
    );
  }
}
