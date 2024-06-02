import 'package:mobile_atma_kitchen/models/Bahan_Baku.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_atma_kitchen/constan.dart';

class BahanBakuController {
  Future<List<BahanBaku>> getAllBahanBaku() async {
    print('${dataUser['token']}');
    try {
      var headers = {
        'Authorization': 'Bearer ${dataUser['token']}',
      };

      var response = await http.get(
        Uri.http(url, '$endpoint/reportBahanBaku/getAllBahanBaku'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> listBahanBaku = jsonDecode(response.body)['data'];
        var dataBahanBaku = listBahanBaku.map((item) {
          return BahanBaku.fromJson(item);
        }).toList();
        return dataBahanBaku;
      } else {
        print('Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: ${e.toString()}');
      throw Exception('Failed: ${e.toString()}');
    }
  }
}
