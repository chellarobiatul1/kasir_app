import 'package:flutter/material.dart';
import '../models/produk_per_kategori.dart'; // ⬅️ SESUAIKAN PATH FILE PRODUK

class KategoriCard extends StatefulWidget {
  final String title;
  final String imagePath;

  // ukuran gambar
  final double imageHeight;
  final double imageWidth;

  // jarak antar gambar
  final EdgeInsets margin;

  const KategoriCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.imageHeight = 160,
    this.imageWidth = double.infinity,
    this.margin = const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
  });

  @override
  State<KategoriCard> createState() => _KategoriCardState();
}

class _KategoriCardState extends State<KategoriCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProdukPerKategori(
              kategori: widget.title,
            ),
          ),
        );
      },

      // ✅ UI ASLI KAMU — TIDAK DIUBAH
      child: Container(
        margin: widget.margin,
        height: widget.imageHeight,
        width: widget.imageWidth,
        child: Stack(
          children: [
            // gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                height: widget.imageHeight,
                width: widget.imageWidth,
              ),
            ),

            // kotak hitam solid persegi di bawah teks
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 40, // tinggi kotak bisa diatur sesuai kebutuhan
                color: Colors.black, // hitam murni
                child: Center(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
