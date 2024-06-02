import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile_atma_kitchen/views/Customer/profileCustomer.dart';
import 'package:mobile_atma_kitchen/views/Customer/Confirm Order/confirmOrder.dart';
import 'package:mobile_atma_kitchen/views/Customer/Produk/layout.produk.dart';
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
    ProdukList(),
    ConfirmOrderApp(),
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
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.white,
            padding: EdgeInsets.all(13),
            gap: 5,
            tabs: const [
              GButton(
                icon: Icons.production_quantity_limits,
                text: 'Produk',
                textColor: Colors.black,
                iconActiveColor: Colors.black,
              ),
              GButton(
                icon: Icons.sort,
                text: 'Confirm Order',
                textColor: Colors.black,
                iconActiveColor: Colors.black,
              ),
              GButton(
                icon: Icons.history,
                text: 'History',
                textColor: Colors.black,
                iconActiveColor: Colors.black,
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
                textColor: Colors.black,
                iconActiveColor: Colors.black,
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
