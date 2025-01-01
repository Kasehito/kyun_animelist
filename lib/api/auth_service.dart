import "package:supabase_flutter/supabase_flutter.dart";

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  //Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    return await supabase.auth
        .signInWithPassword(email: email, password: password);
  }

  //Sign up with email and password
  Future<AuthResponse> signUpWithEmailPassword(
      String email, String password, String username) async {
    return await supabase.auth
        .signUp(email: email, password: password, data: {'username': username});
  }

  //Sign out
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  //Get current user email
  String? getCurrentUserEmail() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  //Get current user username
  String? getCurrentUsername() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.userMetadata?['username'];
  }

  //Reset password
  Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  //Update user profile
  Future<void> updateUserProfile(
      {String? username,}) async {
    await supabase.auth.updateUser(UserAttributes(data: {
      'username': username,
    }));
  }
}
