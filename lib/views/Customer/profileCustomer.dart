import 'package:flutter/material.dart';
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/views/login.view.dart';

class ProfileCustomer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
              "Nama, ${dataUser['no_telpn']}",
              style: TextStyle(fontSize: 24),
            ),
            Text(
              "Nama, ${dataUser['tanggal_lahir']}",
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
