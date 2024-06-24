class BahanBakuPeriode {
  final String nama_bahan_baku;
  final String satuan;
  final int total_usage;

  BahanBakuPeriode({
    required this.nama_bahan_baku,
    required this.satuan,
    required this.total_usage,
  });

  factory BahanBakuPeriode.fromJson(Map<String, dynamic> json) {
    return BahanBakuPeriode(
      nama_bahan_baku: json['nama_bahan_baku'],
      satuan: json['satuan'],
      total_usage: json['total_usage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_bahan_baku': nama_bahan_baku,
      'satuan': satuan,
      'total_usage': total_usage,
    };
  }
}
