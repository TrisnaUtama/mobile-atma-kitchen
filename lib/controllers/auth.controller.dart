import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/views/Customer/DashboardCustomer.dart';
import 'package:mobile_atma_kitchen/views/Pegawai/DashboardPegawai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredentialLogin {
  Future<void> verifiedCredential(
      String email, String password, BuildContext context) async {
    try {
      var response = await post(Uri.http(url, '$endpoint/auth/login'), body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        var user = value['data'];

        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('access_token', value['access_token']);
        await prefs.setInt('id_role', user['id_role'] ?? 0);
        await prefs.setInt('id_saldo', user['id_saldo'] ?? 0);
        await prefs.setString('nama', user['nama'] ?? '');
        await prefs.setString('email', user['email'] ?? '');
        await prefs.setString('password', user['password'] ?? '');
        await prefs.setString('no_telpn', user['no_telpn'] ?? '');
        await prefs.setString('tanggal_lahir', user['tanggal_lahir'] ?? '');
        await prefs.setString('gender', user['gender'] ?? '');
        await prefs.setString('poin', user['poin']?.toString() ?? '0');
        await prefs.setString('alamat', user['alamat'] ?? '');
        await prefs.setString('bonus', user['bonus']?.toString() ?? '0');
        await prefs.setString('gaji', user['gaji']?.toString() ?? '0');

        dataUser = {
          'id': user['id'] ?? 0,
          'id_saldo': user['id_saldo'] ?? 0,
          'id_role': user['id_role'] ?? 0,
          'nama': user['nama'] ?? '',
          'email': user['email'] ?? '',
          'password': user['password'] ?? '',
          'no_telpn': user['no_telpn'] ?? '',
          'tanggal_lahir': user['tanggal_lahir'] ?? '',
          'gender': user['gender'] ?? '',
          'poin': user['poin'] ?? 0,
          'alamat': user['alamat'] ?? '',
          'bonus': user['bonus'] ?? 0,
          'gaji': user['gaji'] ?? 0,
          'token': value['access_token']
        };

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Welcome back, ${user['nama']}"),
          backgroundColor: Colors.green,
        ));

        if (user['id_role'] == null || user['id_role'] == 0) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DashboardCustomer()));
        } else if (user['id_role'] == 3 || user['id_role'] == 1) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DashboardPegawai()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Email or password is wrong"),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email or password is wrong"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
