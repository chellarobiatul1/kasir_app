import '../models/kategori.dart';

class KategoriService {
  // Method untuk mengambil list kategori
  static List<Kategori> getKategori() {
    return [
      Kategori(
        title: 'sayuran',
        imagePath: 'assets/images/SAYUR.jpg',
      ),
      Kategori(
        title: 'buah',
        imagePath: 'assets/images/BUAH.jpg',
      ),
      Kategori(
        title: 'rempah',
        imagePath: 'assets/images/REMPAH.webp',
      ),
      Kategori(
        title: 'pelengkap',
        imagePath: 'assets/images/PELENGKAP.jpg',
      ),
    ];
  }
}
