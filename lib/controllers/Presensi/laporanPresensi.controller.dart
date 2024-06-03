// controllers/Presensi/presensi.controller.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/models/LaporanPresensi.dart';

class PresensiController {
  Future<LaporanPresensi> fetchLaporanPresensi(String date) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${dataUser['token']}',
      };
      var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/v1/laporanPegawai/presensi?date=$date'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('laporan')) {
          List<dynamic> data = responseData['laporan'];
          print(data);
          List<PegawaiLaporan> presensiList =
              data.map((item) => PegawaiLaporan.fromJson(item)).toList();
          return LaporanPresensi(
            laporan: presensiList, totalGajiPegawai: 0,
          );
        } else {
          throw Exception('Invalid response format: missing "data" key');
        }
      } else {
        throw Exception('Failed to load data: ${response.body}');
      }
    } catch (error) {
      throw Exception('Failed to connect to server: $error');
    }
  }
}

