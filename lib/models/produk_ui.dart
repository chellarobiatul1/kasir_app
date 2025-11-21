import 'package:flutter/material.dart';
import '../services/produk_service.dart';

class ProdukUI extends StatefulWidget {
  const ProdukUI({super.key});

  @override
  State<ProdukUI> createState() => _ProdukUIState();
}

class _ProdukUIState extends State<ProdukUI> {
  bool loading = true;
  List produk = [];

  @override
  void initState() {
    super.initState();
    loadProduk();
  }

  Future<void> loadProduk() async {
    final data = await ProdukService().getProduk();

    setState(() {
      produk = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Produk")),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : produk.isEmpty
              ? const Center(child: Text("Tidak ada produk"))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: produk.length,
                  itemBuilder: (context, index) {
                    final p = produk[index];

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // FOTO PRODUK
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: p['gambar'] != null &&
                                      p['gambar'].toString().isNotEmpty
                                  ? Image.network(
                                      p['gambar'],
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 80,
                                      width: 80,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.image),
                                    ),
                            ),

                            const SizedBox(width: 12),

                            // NAMA + HARGA + KATEGORI
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p['nama_produk'] ?? "",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "Kategori: ${p['kategori']}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "Rp ${p['harga_produk']}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
