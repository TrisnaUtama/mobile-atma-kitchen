import 'package:mobile_atma_kitchen/models/Produk.dart';

class Limit_Produk {
  final int id_produk;
  final int limit;
  final String tanggal_limit;
  Produk? produk;

  Limit_Produk(
      {required this.id_produk,
      required this.limit,
      required this.tanggal_limit,
      required this.produk});

  factory Limit_Produk.fromJson(Map<String, dynamic> json) {
  return Limit_Produk(
    id_produk: json['id_produk'] ?? 0, 
    limit: json['limit'] ?? 0, 
    tanggal_limit: json['tanggal_limit'] ?? '',
    produk: json['produk'] == null ? null : Produk.fromJson(json['produk'] as Map<String, dynamic>),
  );
}


  Map<String, dynamic> toJson() {
    return {
      'id_produk': id_produk,
      'limit': limit,
      'tanggal_limit': tanggal_limit,
      'produk': produk?.toJson()
    };
  }
}
