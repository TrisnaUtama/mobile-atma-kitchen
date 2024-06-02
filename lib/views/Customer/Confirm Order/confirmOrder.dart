import 'package:flutter/material.dart';
import 'package:mobile_atma_kitchen/controllers/Confirm Order/confirmOrderController.dart';
import 'package:mobile_atma_kitchen/models/ConfirmOrder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const ConfirmOrderApp());

class ConfirmOrderApp extends StatelessWidget {
  const ConfirmOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<String>(
        future: _getTokenFromStorage(), // Retrieve token from storage
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ConfirmOrderPage(customerId: '123', token: snapshot.data!);
          }
        },
      ),
    );
  }

  Future<String> _getTokenFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }
}

class ConfirmOrderPage extends StatefulWidget {
  final String customerId;
  final String token;

  const ConfirmOrderPage(
      {required this.customerId, required this.token, Key? key})
      : super(key: key);

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  late Future<List<ConfirmOrder>> _confirmOrderFuture;

  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast.init(context);
    _confirmOrderFuture =
        ConfirmOrderController().getShippedOrPickedUpOrdersByCustomer();
  }

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text("Pesanan diterima"),
      ],
    ),
  );

  void _markOrderAsReceived(String orderId) {
    try {
      ConfirmOrderController().updateStatusToSelesai(orderId).then((_) {
        // Jika pembaruan berhasil, Anda mungkin ingin memuat ulang daftar pesanan
        setState(() {
          _confirmOrderFuture =
              ConfirmOrderController().getShippedOrPickedUpOrdersByCustomer();
        });
        // Tampilkan toast
        fToast.showToast(
          child: toast,
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
      }).catchError((error) {
        print('Error updating order status: $error');
        // Tambahkan penanganan kesalahan jika diperlukan
      });
    } catch (error) {
      print('Error updating order status: $error');
      // Tambahkan penanganan kesalahan jika diperlukan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pesanan Terkirim/Dipickup'),
      ),
      body: FutureBuilder<List<ConfirmOrder>>(
        future: _confirmOrderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ConfirmOrderDataTable(
              confirmOrderList: snapshot.data!,
              markOrderAsReceived: _markOrderAsReceived,
            );
          }
        },
      ),
    );
  }
}

class ConfirmOrderDataTable extends StatelessWidget {
  final List<ConfirmOrder> confirmOrderList;
  final Function(String) markOrderAsReceived;

  const ConfirmOrderDataTable({
    required this.confirmOrderList,
    required this.markOrderAsReceived,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
              label: Text('No Nota',
                  style: TextStyle(fontStyle: FontStyle.normal))),
          DataColumn(
              label: Text('Status Pesanan',
                  style: TextStyle(fontStyle: FontStyle.normal))),
          DataColumn(
              label: Text('Action',
                  style: TextStyle(fontStyle: FontStyle.normal))),
        ],
        rows: confirmOrderList
            .map(
              (order) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(order.noNota.toString())),
                  DataCell(Text(order.statusPesanan)),
                  DataCell(
                    GestureDetector(
                      onTap: () {
                        markOrderAsReceived(order.id.toString());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text('Diterima',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
