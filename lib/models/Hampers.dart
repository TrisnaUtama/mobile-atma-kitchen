class Hampers {
  final String gambar, deskripsi, nama_hampers, kategori;
  final int harga, stok;

  Hampers({
    required this.deskripsi,
    required this.gambar,
    required this.harga,
    required this.nama_hampers,
    required this.kategori,
    required this.stok,
  });

  factory Hampers.fromJson(Map<String, dynamic> json) {
    return Hampers(
      deskripsi: json['deskripsi'] ?? '',
      gambar: json['gambar'] ?? '',
      harga: json['harga'] ?? 0,
      stok: json['stok'] ?? 0,
      nama_hampers: json['nama_hampers'] ?? '',
      kategori: json['kategori'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deskripsi': deskripsi,
      'gambar': gambar,
      'harga': harga,
      'stok': stok,
      'nama_hampers': nama_hampers,
      'kategori': kategori,
    };
  }
}
