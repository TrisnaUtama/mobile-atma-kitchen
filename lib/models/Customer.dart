class Customer {
  final int id_saldo;
  final String nama,
      username,
      password,
      email,
      no_telpn,
      tanggal_lahir,
      gender,
      poin;

  Customer({
    required this.id_saldo,
    required this.nama,
    required this.username,
    required this.password,
    required this.email,
    required this.no_telpn,
    required this.tanggal_lahir,
    required this.gender,
    required this.poin,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id_saldo: json['id_saldo'],
      nama: json['nama'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      tanggal_lahir: json['tanggal_lahir'],
      no_telpn: json['no_telpn'],
      gender: json['gender'],
      poin: json['poin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_saldo': id_saldo,
      'nama': nama,
      'username': username,
      'password': password,
      'email': email,
      'tanggal_lahir': tanggal_lahir,
      'no_telpn': no_telpn,
      'gender': gender,
      'poin': poin,
    };
  }
}
