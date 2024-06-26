import 'package:mobile_atma_kitchen/models/Limit_Produk.dart';

class Produk {
  final int? id_penitip, id_resep, harga, stok;
  final DateTime? tanggal_penitipan;
  final String nama_produk, gambar, deskripsi, kategori;
  final int? status;
  List<Limit_Produk>? limit;

  Produk(
      {this.id_penitip,
      required this.id_resep,
      required this.harga,
      required this.stok,
      required this.tanggal_penitipan,
      required this.nama_produk,
      required this.gambar,
      required this.deskripsi,
      required this.kategori,
      required this.status,
      required this.limit});

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id_penitip: json['id_penitip'],
      id_resep: json['id_resep'],
      harga: json['harga'],
      stok: json['stok'],
      tanggal_penitipan: json['tanggal_penitipan'] != null
          ? DateTime.parse(json['tanggal_penitipan'])
          : null,
      nama_produk: json['nama_produk'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
      kategori: json['kategori'],
      status: json['status'],
      limit: json['limit'] != null
          ? List<Limit_Produk>.from(
              json['limit'].map((item) => Limit_Produk.fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_penitip': id_penitip,
      'id_resep': id_resep,
      'harga': harga,
      'stok': stok,
      'tanggal_penitipan': tanggal_penitipan?.toIso8601String(),
      'nama_produk': nama_produk,
      'gambar': gambar,
      'deskripsi': deskripsi,
      'kategori': kategori,
      'status': status,
      'limit':
          limit != null ? limit!.map((item) => item.toJson()).toList() : null,
    };
  }
}
