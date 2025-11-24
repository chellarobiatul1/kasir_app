import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isCustomerExpanded = false;
  bool isTransactionExpanded = false;
  bool isStockExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9E8C5),

      appBar: AppBar(
        backgroundColor: const Color(0xFFD9E8C5),
        elevation: 0,
        toolbarHeight: 85,
        leadingWidth: 130,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "VegMart",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                "Your Dashboard",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_outlined, color: Colors.black, size: 28),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("grafik hari ini", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            _buildChart(),
            const SizedBox(height: 20),
            _buildCardHeader(
              icon: Icons.person_outline,
              title: "Total Pelanggan Aktif",
              value: "6",
              expanded: isCustomerExpanded,
              onTap: () => setState(() => isCustomerExpanded = !isCustomerExpanded),
            ),
            if (isCustomerExpanded) _buildCustomerList(),
            const SizedBox(height: 15),
            _buildCardHeader(
              icon: Icons.receipt_long_outlined,
              title: "Daftar Transaksi Baru",
              value: "4",
              expanded: isTransactionExpanded,
              onTap: () => setState(() => isTransactionExpanded = !isTransactionExpanded),
            ),
            if (isTransactionExpanded) _buildTransactionList(),
            const SizedBox(height: 15),
            _buildCardHeader(
              icon: Icons.inventory_2_outlined,
              title: "Total Stok Produk",
              value: "15 kg",
              expanded: isStockExpanded,
              onTap: () => setState(() => isStockExpanded = !isStockExpanded),
            ),
            if (isStockExpanded) _buildStockList(),
            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: ""),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF3D5F3D),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(12),
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(),
            topTitles: AxisTitles(),
            rightTitles: AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  const labels = ["cabe", "gula", "wortel", "penyedap", "kunir"];
                  if (value.toInt() >= 0 && value.toInt() < labels.length) {
                    return Text(labels[value.toInt()],
                      style: const TextStyle(fontSize: 10, color: Colors.white));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          barGroups: List.generate(5, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: (4 + index).toDouble(),
                  color: Colors.white,
                  width: 14,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCardHeader({
    required IconData icon,
    required String title,
    required String value,
    required bool expanded,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F0D5),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.black),
            const SizedBox(width: 14),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Spacer(),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(width: 10),
            Icon(expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 26),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerList() {
    final customers = ["Chella", "Rotul", "Zahra", "Nadya", "Melati", "Clarissa"];

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: customers.map((name) {
          return ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(name),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFCDE59B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Aktif",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransactionList() {
    final items = ["Chella", "Rotul", "Zahra", "Melati"];

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: items.map((name) {
          return ListTile(
            leading: const Icon(Icons.shopping_cart_outlined),
            title: Text(name),
            subtitle: const Text("Total : Rp 21.000"),
            trailing: const Text("2025"),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStockList() {
    final stock = {
      "Bawang Putih": "13kg",
      "Bawang Merah": "10kg",
      "Cabai": "8kg",
      "Wortel": "3kg",
      "Gobal": "6kg",
      "Kentang": "10kg",
    };

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: stock.entries.map((item) {
          return ListTile(
            title: Text(item.key),
            trailing: Text(
              "Stok : ${item.value}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          );
        }).toList(),
      ),
    );
  }
}
