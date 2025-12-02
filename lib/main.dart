import 'package:flutter/material.dart';
import 'package:kasir_app/models/kategori_model.dart';
import 'package:kasir_app/screens/home/dashboard_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home/welcome_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/login_screen.dart';
import 'models/produk_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ayvgwmbbzvcetohifaex.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF5dmd3bWJienZjZXRvaGlmYWV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE0NjgwMjMsImV4cCI6MjA3NzA0NDAyM30.DGqauPKKPdzoK-zLhKSS5itrNwh78J1vfIAyOV8dsk4',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:
          const WelcomeScreen(), // bisa jadi LoginScreen atau WelcomeScreen sesuai flow

      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/produk': (context) => const ProdukPerKategori(kategori: "sayur",),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}
