import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/views/Customer/DashboardCustomer.dart';
import 'package:mobile_atma_kitchen/views/Pegawai/DashboardPegawai.dart';

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

        await SharedPref.saveStr('access_token', value['access_token']);
        await SharedPref.saveNullableInt('id_role', user['id_role']);
        await SharedPref.saveNullableInt('id_saldo', user['id_saldo']);
        await SharedPref.saveStr('nama', user['nama']);
        await SharedPref.saveStr('email', user['email']);
        await SharedPref.saveStr('password', user['password']);
        await SharedPref.saveStr('no_telpn', user['no_telpn']);
        await SharedPref.saveStr('tanggal_lahir', user['tanggal_lahir']);
        await SharedPref.saveNullableStr('gender', user['gender']);
        await SharedPref.saveNullableStr('poin', user['poin']);
        await SharedPref.saveNullableStr('alamat', user['alamat']);
        await SharedPref.saveNullableStr('bonus', user['bonus']);
        await SharedPref.saveNullableStr('gaji', user['gaji']);

        dataUser = {
          'id': user['id'],
          'id_saldo': user['id_saldo'],
          'id_role': user['id_role'],
          'nama': user['nama'],
          'email': user['email'],
          'password': user['password'],
          'no_telpn': user['no_telpn'],
          'tanggal_lahir': user['tanggal_lahir'],
          'gender': user['gender'],
          'poin': user['poin'],
          'alamat': user['alamat'],
          'bonus': user['bonus'],
          'gaji': user['gaji'],
          'token': value['access_token']
        };

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Welcome back, ${user['nama']}"),
          backgroundColor: Colors.green,
        ));

        if (user['id_role'] == null) {
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
