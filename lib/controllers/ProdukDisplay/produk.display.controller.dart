import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/models/Hampers.dart';
import 'package:mobile_atma_kitchen/models/Produk.dart';

class Produk2Display {
  Future<List<dynamic>> ProdukDisplay() async {
    try {
      var response = await get(Uri.http(url, '$endpoint/limit/getToday'));
      if (response.statusCode == 200) {
        List<dynamic> listProduk = jsonDecode(response.body)['data']['produk'];
        List<dynamic> listHampers =
            jsonDecode(response.body)['data']['hampers'];
        var dataProduk = listProduk.map((item) {
          return Produk.fromJson(item);
        }).toList();
        var dataHampers = listHampers.map((item) {
          return Hampers.fromJson(item);
        }).toList();
        List<dynamic> mergeData = [];
        mergeData.addAll(dataProduk);
        mergeData.addAll(dataHampers);
        print('data :  ${mergeData}');
        return mergeData;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed : ${e.toString()}');
    }
  }
}
