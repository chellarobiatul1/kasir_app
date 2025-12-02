import 'package:flutter/material.dart';
import 'package:kasir_app/services/produk_service.dart';

class ProdukPerKategori extends StatefulWidget {
  final String kategori;
  final String bannerAsset;

  const ProdukPerKategori({
    super.key,
    required this.kategori,
    required this.bannerAsset,
  });

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
      final filtered = data.where((p) {
        return p['kategori'] != null &&
            p['kategori'].toString().toLowerCase() ==
                widget.kategori.toLowerCase();
      }).toList();
      setState(() {
        produk = filtered;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B6E2E),
      extendBodyBehindAppBar: true,

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Text(
                  "searching...",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ),
              Icon(Icons.search, color: Colors.black54, size: 18),
            ],
          ),
        ),
        centerTitle: true,
      ),

      // ================= BODY =================
      body: Stack(
        children: [
          // ===== BANNER =====
         // Misal kamu ingin banner lebar penuh layar & tinggi sesuai proporsi atau tinggi tertentu

SizedBox(
  width: double.infinity,   // full lebar layar
  height: 220,              // silakan atur tingginya
  child: Image.asset(
    widget.bannerAsset,
    fit: BoxFit.cover,
  ),
),



          // ===== CONTAINER PUTIH MELENGKUNG =====
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              decoration: const BoxDecoration(
                color: Color(0xFFF4FBE9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Column(
                children: [
                  // ===== LIST PRODUK =====
                  Expanded(
                    child: loading
                        ? const Center(child: CircularProgressIndicator())
                        : produk.isEmpty
                            ? const Center(
                                child: Text(
                                  "Tidak ada produk",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: produk.length,
                                itemBuilder: (context, i) {
                                  final p = produk[i];
                                  return _buildProdukItem(p);
                                },
                              ),
                  ),

                  // ===== BUTTON TAMBAH =====
                  const SizedBox(height: 6),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8CB56B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 22),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      "tambah produk baru",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ],
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: _bottomNav(),
    );
  }

  // ================= CARD PRODUK =================
  Widget _buildProdukItem(Map p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD3E8B9),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: (p['gambar'] != null && p['gambar'] != "")
                ? Image.network(
                    p['gambar'],
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 60,
                    width: 60,
                    color: Colors.white,
                    child: const Icon(Icons.image),
                  ),
          ),
          const SizedBox(width: 12),

          // ===== TEKS =====
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p['nama_produk'] ?? "",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F4A1B)),
                ),
                const SizedBox(height: 2),
                Text(
                  "1kg - ${p['harga_produk']}",
                  style: const TextStyle(
                      fontSize: 13, color: Colors.green),
                ),
                const SizedBox(height: 2),
                Text(
                  "stok - ${p['stok']} kg",
                  style:
                      const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),

          // ===== EDIT =====
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Color(0xFF9CC980),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit, size: 18),
          ),

          const SizedBox(width: 10),

          // ===== DELETE =====
          GestureDetector(
            onTap: () async {
              await ProdukService().deleteProduk(p['id']);
              loadProduk();
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFFE74C3C),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.delete, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  // ================= BOTTOM NAV =================
  Widget _bottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(color: Color(0xFFF1EFD8)),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.home_outlined, size: 28),
    const Icon(Icons.menu_book_outlined, size: 28),
    const Icon(Icons.person_outline, size: 28),
    const Icon(Icons.dashboard_outlined, size: 28),
    const Icon(Icons.access_time, size: 28),
    const Icon(Icons.settings_outlined, size: 28),
        ],
      ),
    );
  }
}
