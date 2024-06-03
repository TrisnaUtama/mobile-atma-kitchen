import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_atma_kitchen/constan.dart';
import 'package:mobile_atma_kitchen/models/Bahan_Baku_Periode.dart';

class BahanBakuController {
  Future<List<BahanBakuPeriode>> getAllBahanBaku(
      String startDate, String endDate) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${dataUser['token']}',
      };

      var response = await http.get(
        Uri.http(url, '$endpoint/detailPemesanan/getLaporanBahanBakuPeriode', {
          'startDate': startDate,
          'endDate': endDate,
        }),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['totalUsage'] != null &&
            responseBody['totalUsage'] is List) {
          List<dynamic> listBahanBaku = responseBody['totalUsage'];
          var dataBahanBaku = listBahanBaku.map((item) {
            return BahanBakuPeriode.fromJson(item);
          }).toList();
          return dataBahanBaku;
        } else {
          print('Unexpected response format: ${response.body}');
          throw Exception('Unexpected response format');
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: ${e.toString()}');
      throw Exception('Failed: ${e.toString()}');
    }
  }
}
