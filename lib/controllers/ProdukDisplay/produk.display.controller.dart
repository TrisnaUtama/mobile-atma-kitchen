import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/models/Produk.dart';

class Produk2Display {
  Future<List<Produk>> ProdukDisplay() async {
    try {
      var response = await get(Uri.http(url, '$endpoint/limit/getToday'));
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body)['data'];
        var data = list.map((item) {
          return Produk.fromJson(item);
        }).toList();
        print("ini data saya : ${data}");
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed : ${e.toString()}');
    }
  }
}
