import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_atma_kitchen/models/LaporanPresensi.dart';
import 'package:mobile_atma_kitchen/controllers/Presensi/laporanPresensi.controller.dart';

void main() {
  runApp(MaterialApp(
    home: LaporanPegawaiPage(),
  ));
}

class LaporanPegawaiPage extends StatefulWidget {
  @override
  _LaporanPegawaiPageState createState() => _LaporanPegawaiPageState();
}

class _LaporanPegawaiPageState extends State<LaporanPegawaiPage> {
  late Future<LaporanPresensi> futureLaporanPresensi;
  String selectedDate = '2024-06';
  PresensiController controller = PresensiController();

  @override
  void initState() {
    super.initState();
    selectedDate = '2024-06'; // Atau nilai default lainnya
    futureLaporanPresensi = controller.fetchLaporanPresensi(selectedDate);
  }

  void _onDateChanged(String? newDate) {
    if (newDate != null) {
      setState(() {
        selectedDate = newDate;
        futureLaporanPresensi = controller.fetchLaporanPresensi(selectedDate);
      });
    }
  }

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: Text('Laporan Presensi Pegawai'),
    ),
    body: ListView(
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: selectedDate,
                items: <String>[
                  '2024-01',
                  '2024-02',
                  '2024-03',
                  '2024-04',
                  '2024-05',
                  '2024-06',
                  '2024-07',
                  '2024-08',
                  '2024-09',
                  '2024-10',
                  '2024-11',
                  '2024-12'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: _onDateChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: FutureBuilder<LaporanPresensi>(
                  future: futureLaporanPresensi,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (!snapshot.hasData ||
                        snapshot.data!.laporan.isEmpty) {
                      return Text('Data tidak ada');
                    } else {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('Nama')),
                              DataColumn(label: Text('Jumlah Hadir')),
                              DataColumn(label: Text('Jumlah Bolos')),
                              DataColumn(label: Text('Honor Harian')),
                              DataColumn(label: Text('Bonus Rajin')),
                              DataColumn(label: Text('Total')),
                            ],
                            rows: snapshot.data!.laporan.map((pegawai) {
                              return DataRow(cells: [
                                DataCell(Text(pegawai.nama)),
                                DataCell(Text('${pegawai.jumlahHadir}')),
                                DataCell(Text('${pegawai.jumlahBolos}')),
                                DataCell(Text('${pegawai.honorHarian}')),
                                DataCell(Text('${pegawai.bonusRajin}')),
                                DataCell(Text('${pegawai.total}')),
                              ]);
                            }).toList(),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


}
