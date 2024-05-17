class Limit_Produk {
  final int id_produk;
  final int limit;
  final String tanggal_limit;

  Limit_Produk(
      {required this.id_produk,
      required this.limit,
      required this.tanggal_limit,});

  factory Limit_Produk.fromJson(Map<String, dynamic> json) {
  return Limit_Produk(
    id_produk: json['id_produk'] ?? 0, 
    limit: json['limit'] ?? 0, 
    tanggal_limit: json['tanggal_limit'] ?? '',
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id_produk': id_produk,
      'limit': limit,
      'tanggal_limit': tanggal_limit,
    };
  }
}
