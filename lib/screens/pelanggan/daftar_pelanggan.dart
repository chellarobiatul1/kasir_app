import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Pelanggan - Replica',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF6F6F4),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DaftarPelanggan(),
    );
  }
}

class DaftarPelanggan extends StatelessWidget {
  const DaftarPelanggan({Key? key}) : super(key: key);

  // sample data matching the screenshot
  final List<Map<String, String>> customers = const [
    {
      'name': 'ananda riski',
      'id': '110',
      'trx': 'transaksi terbaru : 80.000 ( cash )',
    },
    {
      'name': 'chella robiatul',
      'id': '111',
      'trx': 'transaksi terbaru : 40.000 ( transfer )',
    },
    {
      'name': 'anata agni',
      'id': '112',
      'trx': 'transaksi terbaru : 35.500 ( cash )',
    },
    {
      'name': 'aris indra',
      'id': '113',
      'trx': 'transaksi terbaru : 5.000 ( cash )',
    },
    {
      'name': 'hafiza yudistia',
      'id': '114',
      'trx': 'transaksi terbaru : 100.000 ( transfer )',
    },
  ];

  // colors tuned to match screenshot
  final Color bgHeader = const Color(0xFFEAF3E6); // very light green
  final Color cardBg = const Color(0xFFDDEEC5); // pale green card
  final Color cardAccent = const Color(0xFF97AE70); // darker green accent
  final Color bottomBarBg = const Color(0xFFECECEC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // header area built as a rounded container like screenshot
      body: SafeArea(
        child: Column(
          children: [
            // Header with back arrow and title
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: bgHeader,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 14),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Daftar Pelanggan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          color: Colors.black12,
                          offset: Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),

            // The list area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: ListView.builder(
                  itemCount: customers.length + 1, // +1 for spacing at bottom
                  itemBuilder: (context, index) {
                    if (index == customers.length) {
                      // bottom spacing so floating button doesn't overlap cards
                      return const SizedBox(height: 90);
                    }

                    final item = customers[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // avatar
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.transparent,
                                child: _avatarForIndex(index),
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // text details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['id']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item['trx']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // action icons column
                          Column(
                            children: [
                              const Icon(Icons.more_horiz),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit, size: 18),
                                  ),
                                  const SizedBox(width: 4),
                                  // red delete icon inside small circle
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: Colors.red.shade400),
                                    ),
                                    child: const Icon(Icons.delete, color: Colors.red, size: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // floating button (pill) above bottom nav like screenshot
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 28),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: cardAccent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 4),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.add, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(
              'tambah pelanggan baru',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: bottomBarBg,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_outlined, true),
              _navItem(Icons.menu_book_outlined, false),
              _navItem(Icons.person_outline, false),
              _navItem(Icons.dashboard_outlined, false),
              _navItem(Icons.access_time, false),
              _navItem(Icons.settings_outlined, false),
            ],
          ),
        ),
      ),
    );
  }

  // small helper to return different avatar icons like screenshot
  Widget _avatarForIndex(int index) {
    switch (index) {
      case 0:
        return const Icon(Icons.person, size: 22, color: Colors.black87);
      case 1:
        return const Icon(Icons.face, size: 22, color: Colors.brown);
      case 2:
        return const Icon(Icons.face, size: 22, color: Colors.brown);
      case 3:
        return const Icon(Icons.person, size: 22, color: Colors.black87);
      case 4:
        return const Icon(Icons.face, size: 22, color: Colors.brown);
      default:
        return const Icon(Icons.person, size: 22);
    }
  }

  // nav item builder
  Widget _navItem(IconData icon, bool selected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 22, color: selected ? Colors.black87 : Colors.black54),
      ],
    );
  }
}
