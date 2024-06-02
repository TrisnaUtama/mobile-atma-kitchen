import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile_atma_kitchen/views/Pegawai/Presensi.dart';
import 'package:mobile_atma_kitchen/views/Pegawai/BahanBaku/layout.bahanbaku.dart';
import 'package:mobile_atma_kitchen/views/Pegawai/BahanBakuPeriode/layoutperiode.bahanbaku.dart';

class DashboardPegawai extends StatefulWidget {
  const DashboardPegawai({super.key});

  @override
  State<DashboardPegawai> createState() => _DashboardPegawaiState();
}

class _DashboardPegawaiState extends State<DashboardPegawai> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BahanBakuList(),
    PresensiPegawai(),
    BahanBakuListPeriode(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(242, 242, 242, 242),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
            backgroundColor: Color.fromARGB(242, 242, 242, 242),
            color: Colors.green,
            activeColor: Colors.green,
            tabBackgroundColor: Color.fromARGB(255, 221, 255, 182),
            padding: EdgeInsets.all(13),
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.person,
                text: 'Presensi',
              ),
              GButton(icon: Icons.settings, text: 'Settings'),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
