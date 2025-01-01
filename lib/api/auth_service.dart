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
      String email, String password) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  //Sign out
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  //Get current user
  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }

  //Reset password
  Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  //Update user profile
  Future<void> updateUserProfile(
      {String? fullName, String? username, String? website}) async {
    await supabase.auth.updateUser(UserAttributes(
        data: {'full_name': fullName, 'username': username, 'website': website}));
  }
}
