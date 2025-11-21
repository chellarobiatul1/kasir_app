import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class AuthService {
  static final supabase = SupabaseService.client;

  /// return null jika sukses
  /// return string jika error
  static Future<String?> login(String email, String password) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user == null) {
        return "Email atau password salah";
      }

      return null; // sukses
    } catch (e) {
      return e.toString(); // error
    }
  }

  static Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
