import 'package:flutter/material.dart';
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/views/login.view.dart';
import 'package:mobile_atma_kitchen/views/Customer/Saldo/saldoPage.dart';

class ProfileCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Saldo()));
            },
            icon: Icon(Icons
                .account_balance_wallet,
                color: Colors.blue,), // Icon yang digunakan untuk tombol saldo
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              "Nama : ${dataUser['nama']}",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "Email : ${dataUser['email']}",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "No telp, ${dataUser['no_telpn']}",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "Tanggal lahir, ${dataUser['tanggal_lahir']}",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "Gender, ${dataUser['gender']}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
