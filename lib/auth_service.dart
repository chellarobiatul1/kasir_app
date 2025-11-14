import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class AuthService {
  final supabase = SupabaseService.client;

  Future<AuthResponse> login(String email, String password) {
    return supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() {
    return supabase.auth.signOut();
  }
}
