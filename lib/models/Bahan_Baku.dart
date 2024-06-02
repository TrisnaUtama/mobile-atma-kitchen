class BahanBaku {
  final int id, stok;
  final String nama_bahan_baku, satuan;

  BahanBaku({
    required this.id,
    required this.stok,
    required this.nama_bahan_baku,
    required this.satuan,
  });

  factory BahanBaku.fromJson(Map<String, dynamic> json) {
    return BahanBaku(
      id: json['id'],
      stok: json['stok'],
      nama_bahan_baku: json['nama_bahan_baku'],
      satuan: json['satuan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stok': stok,
      'nama_bahan_baku': nama_bahan_baku,
      'satuan': satuan,
    };
  }
}
