import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile_atma_kitchen/views/Customer/profileCustomer.dart';
import 'package:mobile_atma_kitchen/views/Customer/homePage.dart';
import 'package:mobile_atma_kitchen/views/Customer/Produk/components/layout.produk.dart';
import 'package:mobile_atma_kitchen/views/Customer/historyPage.dart';

class DashboardCustomer extends StatefulWidget {
  const DashboardCustomer({super.key});

  @override
  State<DashboardCustomer> createState() => _DashboardCustomerState();
}

class _DashboardCustomerState extends State<DashboardCustomer> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    // Define your pages here
    // Example:
    HomePage(),
    ProdukList(),
    HistoryPage(),
    ProfileCustomer(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: const Color.fromARGB(242, 242, 242, 242),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                        icon: Icons.production_quantity_limits, text: 'Produk'),
                    GButton(icon: Icons.history, text: 'History'),
                    GButton(
                      icon: Icons.settings,
                      text: 'Settings',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: _onItemTapped,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
