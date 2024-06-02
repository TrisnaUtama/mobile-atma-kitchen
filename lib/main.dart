import 'package:flutter/material.dart';

import 'package:mobile_atma_kitchen/views/landingPage.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_atma_kitchen/views/login.view.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      debugShowCheckedModeBanner: false,
      home: ProdukList(),
    );
  }
}
