import 'package:flutter/material.dart';
import 'package:mobile_atma_kitchen/controllers/Presensi/presensi.controlller.dart';
import 'package:mobile_atma_kitchen/models/Presensi.dart';

/// Flutter code sample for [DataTable].

void main() => runApp(const PresensiPegawai());

class PresensiPegawai extends StatefulWidget {
  const PresensiPegawai({Key? key}) : super(key: key);

  @override
  _PresensiPegawaiState createState() => _PresensiPegawaiState();
}

class _PresensiPegawaiState extends State<PresensiPegawai> {
  late Future<List<Presensi>> _presensiFuture;

  @override
  void initState() {
    super.initState();
    _presensiFuture = PresensiController().getAllPresensi();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Presensi Pegawai'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Edit'),
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<Presensi>>(
          future: _presensiFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return PresensiDataTable(presensiList: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

class PresensiDataTable extends StatelessWidget {
  final List<Presensi> presensiList;

  const PresensiDataTable({required this.presensiList});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
            label: Text('Id', style: TextStyle(fontStyle: FontStyle.normal))),
        DataColumn(
            label: Text('Tanggal Presensi',
                style: TextStyle(fontStyle: FontStyle.normal))),
        DataColumn(
            label:
                Text('Status', style: TextStyle(fontStyle: FontStyle.normal))),
      ],
      rows: presensiList
          .map(
            (presensi) => DataRow(
              cells: <DataCell>[
                DataCell(Text(presensi.id_pegawai)),
                DataCell(Text(presensi.tanggal_presensi)),
                DataCell(Text(presensi.status_presensi)),
              ],
            ),
          )
          .toList(),
    );
  }
}
