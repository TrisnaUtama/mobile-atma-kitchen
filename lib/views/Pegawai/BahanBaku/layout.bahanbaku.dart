import 'package:flutter/material.dart';
import 'package:mobile_atma_kitchen/controllers/bahanbaku.controller/bahan_baku.controller.dart';
import 'package:mobile_atma_kitchen/models/Bahan_Baku.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class BahanBakuList extends StatefulWidget {
  const BahanBakuList({super.key});

  @override
  _BahanBakuListState createState() => _BahanBakuListState();
}

class _BahanBakuListState extends State<BahanBakuList> {
  late Future<List<BahanBaku>> _futureBahanBaku;

  @override
  void initState() {
    super.initState();
    _futureBahanBaku = BahanBakuController().getAllBahanBaku();
  }

  Future<void> _printData() async {
    final doc = pw.Document();
    final bahanBakuList = await _futureBahanBaku;
    DateTime now = new DateTime.now();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a3,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Atma Kitchen'),
              pw.Text('Jl. Centralpark No. 10 Yogyakarta'),
              pw.SizedBox(height: 20),
              pw.Text('LAPORAN Stok Bahan Baku'),
              pw.Text('Tanggal cetak: ${now}'),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Nama Bahan Baku',
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Satuan',
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Stok',
                        ),
                      ),
                    ],
                  ),
                  ...bahanBakuList.map((bahanBaku) {
                    return pw.TableRow(
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(bahanBaku.nama_bahan_baku),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(bahanBaku.satuan),
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(bahanBaku.stok.toString()),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Bahan Baku List'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: _printData,
          ),
        ],
      ),
      body: FutureBuilder<List<BahanBaku>>(
        future: _futureBahanBaku,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          List<BahanBaku> data = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Nama Bahan Baku',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Stok',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Satuan',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
                rows: data.map((bahanBaku) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text(bahanBaku.nama_bahan_baku)),
                      DataCell(Text(bahanBaku.stok.toString())),
                      DataCell(Text(bahanBaku.satuan)),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _printData,
        child: Icon(Icons.print),
      ),
    );
  }
}
