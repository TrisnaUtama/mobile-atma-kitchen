class PegawaiLaporan {
  final String nama;
  final int jumlahHadir;
  final int jumlahBolos;
  final int honorHarian;
  final int bonusRajin;
  final int total;

  PegawaiLaporan({
    required this.nama,
    required this.jumlahHadir,
    required this.jumlahBolos,
    required this.honorHarian,
    required this.bonusRajin,
    required this.total,
  });

  factory PegawaiLaporan.fromJson(Map<String, dynamic> json) {
  return PegawaiLaporan(
    nama: json['nama'],
    jumlahHadir: json['jumlah_hadir'] ?? 0, 
    jumlahBolos: json['jumlah_bolos'] ?? 0, 
    honorHarian: json['honor_harian'] ?? 0, 
    bonusRajin: json['bonus_rajin'] ?? 0, 
    total: json['total'] ?? 0, 
  );
}

}
class LaporanPresensi {
  final List<PegawaiLaporan> laporan;
  final int totalGajiPegawai;

  LaporanPresensi({
    required this.laporan,
    this.totalGajiPegawai = 0, 
  });

  factory LaporanPresensi.fromJson(Map<String, dynamic> json) {
    var laporanJson = json['laporan'] as List;
    List<PegawaiLaporan> laporanList = laporanJson.map((i) => PegawaiLaporan.fromJson(i)).toList();

    return LaporanPresensi(
      laporan: laporanList,
      totalGajiPegawai: json['total_gaji_pegawai'] ?? 0, 
    );
  }
}


