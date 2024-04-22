import 'package:flutter/material.dart';
import 'package:mobile_atma_kitchen/constan.dart';

class DashboardCustomer extends StatefulWidget {
  const DashboardCustomer({super.key});

  @override
  State<DashboardCustomer> createState() => _DashboardCustomerState();
}

class _DashboardCustomerState extends State<DashboardCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "${dataUser['nama']} userr",
        ),
      ),
    );
  }
}
