import 'package:flutter/material.dart';
import '../services/produk_service.dart';

class ProdukPerKategori extends StatefulWidget {
  final String kategori;

  const ProdukPerKategori({super.key, required this.kategori});

  @override
  State<ProdukPerKategori> createState() => _ProdukPerKategoriState();
}

class _ProdukPerKategoriState extends State<ProdukPerKategori> {
  bool loading = true;
  List produk = [];

  @override
  void initState() {
    super.initState();
    loadProduk();
  }

  Future<void> loadProduk() async {
  try {
    final data = await ProdukService().getProduk();

    print("SEMUA DATA PRODUK: $data");
    print("KATEGORI DIKLIK: ${widget.kategori}");

    final filtered = data.where((p) {
      return p['kategori'] != null &&
          p['kategori'].toString().toLowerCase() ==
              widget.kategori.toLowerCase();
    }).toList();

    print("HASIL FILTER: $filtered");

    setState(() {
      produk = filtered;
      loading = false;
    });

  } catch (e) {
    print("ERROR LOAD PRODUK: $e");

    setState(() {
      loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Gagal load produk: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kategori: ${widget.kategori}")),

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
                        // FOTO
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                              p['gambar'] != null &&
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

                        // INFO
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
                                "Rp ${p['harga_produk']}",
                                style: const TextStyle(color: Colors.green),
                              ),

                              const SizedBox(height: 4),

                              Text("Kategori: ${p['kategori']}"),
                            ],
                          ),
                        ),

                        // ✅ DELETE
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Hapus Produk"),
                                content: Text("Hapus ${p['nama_produk']}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Batal"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Hapus"),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await ProdukService().deleteProduk(p['id']);
                              loadProduk(); // refresh
                            }
                          },
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
