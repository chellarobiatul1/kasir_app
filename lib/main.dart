import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'produk_ui.dart';

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
      home: const ProdukUI(),
    );
  }
}
