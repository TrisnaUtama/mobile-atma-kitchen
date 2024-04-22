import 'package:flutter/material.dart';
import 'package:mobile_atma_kitchen/constan.dart';

class DashboardPegawai extends StatefulWidget {
  const DashboardPegawai({super.key});

  @override
  State<DashboardPegawai> createState() => _DashboardPegawaiState();
}

class _DashboardPegawaiState extends State<DashboardPegawai> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "${dataUser['nama']} pegawaiii",
        ),
      ),
    );
  }
}
