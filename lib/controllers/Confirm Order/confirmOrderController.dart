import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/models/ConfirmOrder.dart';

class ConfirmOrderController {
  Future<List<ConfirmOrder>> getShippedOrPickedUpOrdersByCustomer() async {
    try {
      print(dataUser["token"]);
      final response = await http.get(
        Uri.http(url,
            '$endpoint/detailPemesanan/getShippedOrPickedUpOrdersByCustomer'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dataUser["token"]}',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('data')) {
          List<dynamic> data = responseData['data'];

          // Map the data to Presensi objects
          List<ConfirmOrder> presensiList =
              data.map((item) => ConfirmOrder.fromJson(item)).toList();
          print(presensiList);
          return presensiList;
        } else {
          throw Exception('Invalid response format: missing "data" key');
        }
      } else {
        throw Exception('Failed to load data: ${response.body}');
      }
    } catch (error) {
      print('celak');
      throw Exception('Failed to connect to server: $error');
    }
  }

  Future<List<ConfirmOrder>> updateStatusToSelesai(String orderId) async {
    try {
      final response = await http.post(
        Uri.http(
            url, '$endpoint/detailPemesanan/updateStatusToSelesai/$orderId'),
        headers: <String, String>{
          'Authorization': 'Bearer ${dataUser["token"]}',
        },
      );
      if (response.statusCode == 200) {
        // Jika pembaruan berhasil, Anda mungkin ingin memuat ulang daftar pesanan
        return getShippedOrPickedUpOrdersByCustomer();
      } else {
        throw Exception(
            'Failed to update status to "selesai": ${response.body}');
      }
    } catch (error) {
      print('Failed to connect to server: $error');
      throw Exception('Failed to connect to server: $error');
    }
  }
}
