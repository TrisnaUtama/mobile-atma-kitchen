import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/models/Produk.dart';
import 'package:mobile_atma_kitchen/models/Limit_Produk.dart';

class Produk2Display {
  // Future<List<Produk>> ProdukToDisplay() async {
  //   try {
  //     var response = await get(Uri.http(url, '$endpoint/limit/getToday'));
  //     if (response.statusCode == 200) {
  //       List<dynamic> list = jsonDecode(response.body)['data'];
  //       List<Produk> data = list.map((e) => Produk.fromJson(e)).toList();
  //       print('${data}');
  //       return data;
  //     } else {
  //       throw Exception('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load data: ${e.toString()}');
  //   }
  // }

  Future<List<Limit_Produk>> ProdukDisplay() async {
    try {
      var response = await get(Uri.http(url, '$endpoint/limit/getToday'));
      if (response.statusCode == 200) {
        List<dynamic> list = jsonDecode(response.body)['data'];
        var data = list.map((item) {
          return Limit_Produk.fromJson(item);
        }).toList();
        print("ini data saya : ${data}");
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: ${e.toString()}');
    }
  }
}
