import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/models/Presensi.dart';

class PresensiController {
  Future<List<Presensi>> getAllPresensi() async {
    try {
      final response =
          await http.get(Uri.http(url, '$endpoint/presensi/getAllPresensi'));

      if (response.statusCode == 200) {
        // Decode JSON response
        Map<String, dynamic> responseData = json.decode(response.body);

        // Check if the response contains a key for the presensi data
        if (responseData.containsKey('data')) {
          List<dynamic> data = responseData['data'];

          // Map the data to Presensi objects
          List<Presensi> presensiList =
              data.map((item) => Presensi.fromJson(item)).toList();
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

  updatePresensiStatus(String id_presensi, String newStatus) {}
}
