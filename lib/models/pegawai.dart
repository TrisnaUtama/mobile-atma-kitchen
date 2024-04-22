class Pegawai {
  final int id_role;
  final String nama,
      alamat,
      no_telpn,
      tanggal_lahir,
      gender,
      username,
      password;
  final double bonus, gaji;

  Pegawai({
    required this.id_role,
    required this.nama,
    required this.alamat,
    required this.no_telpn,
    required this.tanggal_lahir,
    required this.username,
    required this.password,
    required this.gender,
    required this.gaji,
    required this.bonus,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id_role: json['id_role'],
      nama: json['nama'],
      alamat: json['alamat'],
      no_telpn: json['no_telpn'],
      tanggal_lahir: json['tanggal_lahir'],
      username: json['username'],
      password: json['password'],
      gender: json['gender'],
      gaji: json['gaji'],
      bonus: json['bonus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_role': id_role,
      'nama': nama,
      'alamat': alamat,
      'no_telpn': no_telpn,
      'tanggal_lahir': tanggal_lahir,
      'username': username,
      'password': password,
      'gender': gender,
      'gaji': gaji,
      'bonus': bonus,
    };
  }
}
