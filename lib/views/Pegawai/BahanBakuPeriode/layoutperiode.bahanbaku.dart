import 'package:flutter/material.dart';
import 'package:mobile_atma_kitchen/controllers/periodebahanbaku/periodeBahanBaku.controller.dart';
import 'package:mobile_atma_kitchen/models/Bahan_Baku_Periode.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class BahanBakuListPeriode extends StatefulWidget {
  const BahanBakuListPeriode({super.key});

  @override
  _BahanBakuListPeriodeState createState() => _BahanBakuListPeriodeState();
}

class _BahanBakuListPeriodeState extends State<BahanBakuListPeriode> {
  Future<List<BahanBakuPeriode>>? _futureBahanBaku;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchData() async {
    String startDate = _startDateController.text;
    String endDate = _endDateController.text;
    setState(() {
      _futureBahanBaku =
          BahanBakuController().getAllBahanBaku(startDate, endDate);
    });
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now())
      setState(() {
        controller.text = _dateFormat.format(picked);
      });
  }

  Future<void> _printData() async {
    final doc = pw.Document();
    if (_futureBahanBaku == null) return;
    final bahanBakuListPeriode = await _futureBahanBaku!;
    DateTime now = DateTime.now();
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
                          'Total Usage',
                        ),
                      ),
                    ],
                  ),
                  ...bahanBakuListPeriode.map((bahanBaku) {
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
                          child: pw.Text(bahanBaku.total_usage.toString()),
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
        title: Text('List Bahan Baku Periode Tertentu'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: _printData,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _startDateController,
              decoration: InputDecoration(
                labelText: 'Start Date',
                hintText: 'yyyy-MM-dd',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, _startDateController),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _endDateController,
              decoration: InputDecoration(
                labelText: 'End Date',
                hintText: 'yyyy-MM-dd',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, _endDateController),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _fetchData,
            child: Text('Fetch Data'),
          ),
          Expanded(
            child: _futureBahanBaku == null
                ? Center(child: Text('Please enter the dates to fetch data'))
                : FutureBuilder<List<BahanBakuPeriode>>(
                    future: _futureBahanBaku,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No data available'));
                      }

                      List<BahanBakuPeriode> data = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Nama Bahan Baku',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Total Usage',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Satuan',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                            rows: data.map((bahanBaku) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(bahanBaku.nama_bahan_baku)),
                                  DataCell(
                                      Text(bahanBaku.total_usage.toString())),
                                  DataCell(Text(bahanBaku.satuan)),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _printData,
        child: Icon(Icons.print),
      ),
    );
  }
}
