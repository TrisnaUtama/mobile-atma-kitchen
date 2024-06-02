import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:u_credit_card/u_credit_card.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_atma_kitchen/models/HistorySaldo.dart';

class Saldo extends StatefulWidget {
  const Saldo({super.key});

  @override
  State<Saldo> createState() => _SaldoState();
}

class SaldoCustomerController {
  Future<double> getSaldoCustomer() async {
    print('${dataUser['token']}');
    try {
      var headers = {
        'Authorization': 'Bearer ${dataUser['token']}',
      };

      var response = await http.get(
        Uri.parse(
            'http://10.0.2.2:8000/api/v1/saldoCustomer/getSaldo/${dataUser['id']}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        return data['saldo']['jumlah_saldo'];
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: ${e.toString()}');
      throw Exception('Failed: ${e.toString()}');
    }
  }

  Future<void> withdrawSaldo(double amount) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${dataUser['token']}',
        'Content-Type': 'application/json',
      };

      var body = jsonEncode({'jumlah_saldo': amount});

      var response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/v1/saldoCustomer/tarikSaldo'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        print('Withdrawal successful');
      } else if (response.statusCode == 400) {
        var error = jsonDecode(response.body)['message'];
        throw Exception(error);
      } else {
        throw Exception('Failed to withdraw saldo: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: ${e.toString()}');
      throw Exception('Failed: ${e.toString()}');
    }
  }
}

class Pengguna {
  final String nama;
  final String noTelpn;
  final String tanggalLahir;
  final int jumlahSaldo;

  Pengguna({
    required this.nama,
    required this.noTelpn,
    required this.tanggalLahir,
    required this.jumlahSaldo,
  });

  factory Pengguna.fromJson(Map<String, dynamic> json) {
    return Pengguna(
      nama: json['nama'],
      noTelpn: json['no_telpn'],
      tanggalLahir: json['tanggal_lahir'],
      jumlahSaldo: json['saldo']['jumlah_saldo'],
    );
  }
}

class PenggunaFetcher {
  static Future<Pengguna> fetchSaldo() async {
    try {
      var headers = {
        'Authorization': 'Bearer ${dataUser['token']}',
      };

      final response = await http.get(
        Uri.parse(
            'http://10.0.2.2:8000/api/v1/saldoCustomer/getSaldo/${dataUser['id']}'),
        headers: headers,
      );

      print(response.body);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        if (parsed['status']) {
          final data = parsed['data'];
          return Pengguna.fromJson(data);
        } else {
          throw Exception(parsed['message']);
        }
      } else {
        throw Exception('Failed to load saldo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}

class History {
  final int id;
  final int customerId;
  final double saldoAmount;
  final DateTime withdrawalDate;
  final DateTime confirmationDate;
  final String status;

  History({
    required this.id,
    required this.customerId,
    required this.saldoAmount,
    required this.withdrawalDate,
    required this.confirmationDate,
    required this.status,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      customerId: json['id_customer'],
      saldoAmount: json['jumlah_saldo'].toDouble(),
      withdrawalDate: DateTime.parse(json['tanggal_penarikan']),
      confirmationDate: DateTime.parse(json['tanggal_konfirmasi']),
      status: json['status'],
    );
  }
}

class HistoryFetcher {
  static Future<List<History>> fetchHistory() async {
    try {
      var headers = {
        'Authorization': 'Bearer ${dataUser['token']}',
      };

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/v1/saldoCustomer/history'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);

        // Asumsikan respons JSON berbentuk objek dengan kunci 'data' yang berisi list
        if (parsed is Map<String, dynamic> && parsed['data'] is List) {
          List<dynamic> dataList = parsed['data'];
          List<History> historyList = dataList.map<History>((json) {
            if (json is Map<String, dynamic>) {
              return History.fromJson(json);
            } else {
              throw Exception(
                  'Invalid history data format: element is not a Map');
            }
          }).toList();
          return historyList;
        } else {
          throw Exception(
              'Invalid history data format: response is not a List');
        }
      } else {
        throw Exception('Failed to load history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching history: $e');
      throw Exception('Error fetching history: $e');
    }
  }
}

class _SaldoState extends State<Saldo> {
  final TextEditingController _nominalController = TextEditingController();

  void _showWithdrawModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tarik Saldo'),
          content: TextField(
            controller: _nominalController,
            decoration: InputDecoration(hintText: "Masukkan nominal saldo"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Tarik"),
              onPressed: () async {
                double amount = double.tryParse(_nominalController.text) ?? 0;
                if (amount > 0) {
                  try {
                    await SaldoCustomerController().withdrawSaldo(amount);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Penarikan saldo berhasil diajukan')),
                    );
                    setState(() {});
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Masukkan nominal yang valid')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Saldo'),
      ),
      body: Container(
        margin: EdgeInsets.all(50),
        child: FutureBuilder<Pengguna>(
          future: PenggunaFetcher.fetchSaldo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final pengguna = snapshot.data!;
              return Column(
                children: [
                  CreditCardUi(
                    cardHolderFullName: pengguna.nama,
                    cardNumber: pengguna.jumlahSaldo.toString(),
                    validFrom: pengguna.noTelpn,
                    validThru: pengguna.tanggalLahir,
                    topLeftColor: Colors.blue,
                    doesSupportNfc: true,
                    placeNfcIconAtTheEnd: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showWithdrawModal(context);
                    },
                    child: Text('Tarik Saldo'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Riwayat Transaksi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<History>>(
                      future: HistoryFetcher.fetchHistory(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final List<History> historyList = snapshot.data!;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Jumlah Saldo')),
                                DataColumn(label: Text('Tanggal Penarikan')),
                                DataColumn(label: Text('Tanggal Konfirmasi')),
                                DataColumn(label: Text('Status')),
                              ],
                              rows: historyList.map((history) {
                                return DataRow(cells: [
                                  DataCell(Text(history.id.toString())),
                                  DataCell(
                                      Text(history.saldoAmount.toString())),
                                  DataCell(Text(history.withdrawalDate
                                      .toLocal()
                                      .toString())),
                                  DataCell(Text(history.confirmationDate
                                      .toLocal()
                                      .toString())),
                                  DataCell(Text(history.status)),
                                ]);
                              }).toList(),
                            ),
                          );
                        } else {
                          return Center(
                              child: Text('No transaction history available'));
                        }
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
