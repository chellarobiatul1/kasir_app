import 'package:flutter/material.dart';
import 'package:kasir_app/services/kategori_service.dart';
import 'package:kasir_app/widgets/kategori_card.dart';
import 'package:kasir_app/models/kategori.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Memanggil list kategori dari service
    final List<Kategori> categories = KategoriService.getKategori();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color(0xFF46442E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Management Produk',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return KategoriCard(title: cat.title, imagePath: cat.imagePath);
        },
      ),

      // ✨ Tambahkan bottomNavigationBar di sini
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, -3),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Icon(Icons.home_outlined, size: 28),
            ),
            const Icon(Icons.menu_book_outlined, size: 28),
            const Icon(Icons.person_outline, size: 28),
            const Icon(Icons.dashboard_outlined, size: 28),
            const Icon(Icons.access_time, size: 28),
            const Icon(Icons.settings_outlined, size: 28),
          ],
        ),
      ),
    );
  }
}
