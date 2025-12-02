import 'package:flutter/material.dart';
import 'package:kasir_app/screens/laporan/laporan_kasir.dart';
import 'package:kasir_app/screens/pelanggan/daftar_pelanggan.dart';
import 'package:kasir_app/screens/produk/namajement_stok.dart';
import 'package:kasir_app/screens/settings_page.dart';
import 'package:kasir_app/screens/home/dashboard_screen.dart';
import 'package:kasir_app/screens/kasir/keranjang.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProdukPage(),
    );
  }
}

class ProdukPage extends StatelessWidget {
  const ProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Produk',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
       actions: [
  Padding(
    padding: const EdgeInsets.only(right: 16.0),
    child: IconButton(
      icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Keranjang()),
        );
      },
    ),
  ),
],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "search...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/header.jpg',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var icon in [
                    'sayur1.png',
                    'sayur2.png',
                    'sayur3.png',
                    'sayur4.png',
                  ])
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/$icon', height: 32),
                    ),
                ],
              ),

              const SizedBox(height: 24),

              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  produkCard(
                    'Pisang',
                    '9.000/kg',
                    'pisang.jpg',
                    highlight: true,
                  ),
                  produkCard('Apel', '9.000/kg', 'apel.jpg'),
                  produkCard('Selada', '12.000/kg', 'selada.png'),
                  produkCard('Pakchoy', '6.000/kg', 'pakcoy.png'),
                  produkCard(
                    'Jagung',
                    '7.000/kg',
                    'jagung.png',
                    highlight: true,
                  ),
                  produkCard('Tomat', '7.000/kg', 'tomat.png', highlight: true),
                  produkCard('Timun', '6.000/kg', 'timun.png'),
                  produkCard('Terong', '6.000/kg', 'terong.png'),
                ],
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
  color: Colors.white,
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Home
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          child: const Icon(Icons.home_outlined, size: 28),
        ),

        // Book
         GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ManajemenStokScreen()),
            );
          },
        child: const Icon(Icons.menu_book_outlined, size: 28),
         ),

        // Profile
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DaftarPelanggan()),
            );
          },
          child: const Icon(Icons.person_outline, size: 28),
        ),

        // Dashboard
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
          child: const Icon(Icons.dashboard_outlined, size: 28),
        ),

        // History / Time
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LaporanKasir()),
            );
          },
          child: const Icon(Icons.access_time, size: 28),
        ),

        // Settings - FIXED
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
          child: const Icon(Icons.settings_outlined, size: 28),
        ),
      ],
    ),
  ),
),
    );
  }

  Widget produkCard(
    String title,
    String price,
    String image, {
    bool highlight = false,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (highlight)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Promo',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),

          const SizedBox(height: 8),

          Image.asset('assets/$image', height: 90),

          const SizedBox(height: 8),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),

          Text(price, style: const TextStyle(color: Colors.grey, fontSize: 14)),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.green,
              child: const Icon(Icons.add, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
