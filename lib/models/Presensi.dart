class Presensi {
  final String id_pegawai;
  final String tanggal_presensi;
  final String status_presensi;

  Presensi({
    required this.id_pegawai,
    required this.tanggal_presensi,
    required this.status_presensi,
  });

  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      id_pegawai:
          json['id_pegawai'] != null ? json['id_pegawai'].toString() : '',
      tanggal_presensi:
          json['tanggal_presensi'] != null ? json['tanggal_presensi'] : '',
      status_presensi:
          json['status_presensi'] != null ? json['status_presensi'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      
      'id_pegawai': id_pegawai,
      'tanggal_presensi': tanggal_presensi,
      'status': status_presensi,
    };
  }
}
