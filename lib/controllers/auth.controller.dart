import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/views/Customer/DashboardCustomer.dart';
import 'package:mobile_atma_kitchen/views/Pegawai/DashboardPegawai.dart';

class CredentialLogin {
  verifiedCredential(String email, String password, BuildContext context) {
    var response = post(Uri.http(url, '$endpoint/auth/login'), body: {
      'email': email,
      'password': password,
    });

    response.then((value) {
      if (value.statusCode == 200) {
        print(value.statusCode);
        var user = jsonDecode(value.body)['data'];
        var token = jsonDecode(value.body)['access_token'];
        SharedPref.saveInt('id', user['id']);
        SharedPref.saveNullableInt('id_role', user['id_role']);
        SharedPref.saveNullableInt('id_saldo', user['id_saldo']);
        SharedPref.saveStr('nama', user['nama']);
        SharedPref.saveStr('token', token);
        SharedPref.saveStr('email', user['email']);
        SharedPref.saveStr('password', user['password']);
        SharedPref.saveStr('no_telpn', user['no_telpn']);
        SharedPref.saveStr('tanggal_lahir', user['tanggal_lahir']);
        SharedPref.saveNullableStr('gender', user['gender']);
        SharedPref.saveNullableStr('poin', user['poin']);
        SharedPref.saveNullableStr('alamat', user['alamat']);
        SharedPref.saveNullableStr('bonus', user['bonus']);
        SharedPref.saveNullableStr('gaji', user['gaji']);
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
          'token': token
        };
        if (user['id_role'] == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Welcome back, ${user['nama']}"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DashboardCustomer()));
        } else if (user['id_role'] == 3) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Welcome back, ${user['nama']}"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DashboardPegawai()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Email or password is wrong"),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        print(value.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email or password is wrong"),
          backgroundColor: Colors.red,
        ));
      }
    });
  }
}
