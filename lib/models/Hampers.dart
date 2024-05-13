class Hampers {
  final String gambar, deskripsi, nama_hampers;
  final int harga;

  Hampers({
    required this.deskripsi,
    required this.gambar,
    required this.harga,
    required this.nama_hampers,
  });

  factory Hampers.fromJson(Map<String, dynamic> json) {
    return Hampers(
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
      harga: json['harga'],
      nama_hampers: json['nama_hampers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deskripsi': deskripsi,
      'gambar': gambar,
      'harga': harga,
      'nama_hampers': nama_hampers,
    };
  }
}
