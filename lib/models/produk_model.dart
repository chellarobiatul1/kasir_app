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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      // ------------------ APPBAR ------------------
      appBar: AppBar(
        backgroundColor: const Color(0xFF60693D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "searching...",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search, color: Colors.white),
          )
        ],
      ),

      body: Stack(
  children: [
    // ================= BANNER GAMBAR =================
    SizedBox(
      height: 190,
      width: double.infinity,
      child: Image.asset(
        'assets/images/SAYUR.jpg',
        fit: BoxFit.cover,
      ),
    ),

    // ================= PUTIH MELENGKUNG =================
    Positioned(
      top: 150,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(16, 22, 16, 8),
        decoration: const BoxDecoration(
          color: Color(0xFFF5FFEC),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // ========= JUDUL =========
            Text(
              widget.kategori,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D643B),
              ),
            ),

            const SizedBox(height: 12),

            // ========= LIST PRODUK =========
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : produk.isEmpty
                      ? const Center(child: Text("Tidak ada produk"))
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: produk.length,
                          itemBuilder: (context, index) {
                            final p = produk[index];
                            return _buildProdukItem(p);
                          },
                        ),
            ),

            // ========= BUTTON TAMBAH PRODUK =========
            const SizedBox(height: 6),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA6CF84),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "tambah produk baru",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 14),

                  // LIST PRODUK
                  Expanded(
                    child: loading
                        ? const Center(child: CircularProgressIndicator())
                        : produk.isEmpty
                            ? const Center(
                                child: Text("Tidak ada produk",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54)),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: produk.length,
                                itemBuilder: (context, index) {
                                  final p = produk[index];
                                  return _buildProdukItem(p);
                                },
                              ),
                  ),

                  const SizedBox(height: 12),
                  // Di dalam Column di Positioned … (setelah Expanded list)
const SizedBox(height: 12),

ElevatedButton.icon(
  onPressed: () {
    // TODO: fungsi tambah produk baru, misal:
    // Navigator.push(... ke screen form produk)
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF84A460), // hijau
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    elevation: 2,
  ),
  icon: const Icon(Icons.add, color: Colors.white),
  label: const Text(
    "tambah produk baru",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
),

const SizedBox(height: 18),


                  // ------------------ BUTTON TAMBAH PRODUK ------------------
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF84A460),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 6),
                          Text(
                            "tambah produk baru",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ------------------ BOTTOM NAVIGATION ------------------
      bottomNavigationBar: _bottomNav(),
    );
  }

  // ============================================================
  //                  WIDGET PRODUK ITEM
  // ============================================================
  Widget _buildProdukItem(Map p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF4C7),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          // GAMBAR BULAT
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: p['gambar'] != null && p['gambar'] != ""
                ? Image.network(
                    p['gambar'],
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 60,
                    width: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image),
                  ),
          ),

          const SizedBox(width: 12),

          // INFORMASI PRODUK
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p['nama_produk'],
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Text("1kg - Rp ${p['harga_produk']}",
                    style: const TextStyle(
                        fontSize: 14, color: Colors.green)),
                const SizedBox(height: 3),
                Text("stok - ${p['stok']}",
                    style:
                        const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),

          const SizedBox(width: 6),

          // EDIT BUTTON
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Color(0xFFB7D59B),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit, size: 18),
          ),

          const SizedBox(width: 10),

          // DELETE BUTTON
          GestureDetector(
            onTap: () async {
              await ProdukService().deleteProduk(p['id']);
              loadProduk();
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFFFF5147),
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

  // ============================================================
  //                   BOTTOM NAV BAR
  // ============================================================
  Widget _bottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFECEAD5),
      ),
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
