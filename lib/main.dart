import 'package:flutter/material.dart';
import 'package:mobile_atma_kitchen/views/login.view.dart';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = 'id_ID';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
