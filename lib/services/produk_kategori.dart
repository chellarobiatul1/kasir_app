import 'package:flutter/material.dart';

// ---------------- Model ----------------
class Category {
  final String title;
  final String imagePath;

  Category({required this.title, required this.imagePath});
}

// ---------------- Service ----------------
class CategoryService {
  static List<Category> getCategories() {
    return [
      Category(title: 'sayuran', imagePath: 'assets/images/sayuran.png'),
      Category(title: 'buah', imagePath: 'assets/images/buah.png'),
      Category(title: 'rempah', imagePath: 'assets/images/rempah.png'),
      Category(title: 'pelengkap', imagePath: 'assets/images/pelengkap.png'),
    ];
  }
}

// ---------------- Widget Kartu ----------------
class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      height: 120,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Gambar kategori
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          // Overlay gelap
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.0),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          // Teks kategori
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ---------------- Screen Produk Kategori ----------------
class ProdukKategoriScreen extends StatelessWidget {
  const ProdukKategoriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryService.getCategories();

    return Scaffold(
      backgroundColor: const Color(0xFF46442E), // warna latar persis gambar
      appBar: AppBar(
        backgroundColor: const Color(0xFF46442E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
          return CategoryCard(title: cat.title, imagePath: cat.imagePath);
        },
      ),
    );
  }
}
