class ConfirmOrder {
  final int id;
  final int idCustomer;
  final String tanggalPemesanan;
  final String tanggalPembayaran;
  final String tanggalDiambil;
  final int jarakDelivery;
  final int ongkir;
  final int poinPesanan;
  final int potonganPoin;
  final String statusPesanan;
  final double? uangCustomer;
  final double? tip;
  final int? idAlamat;
  final String noNota;
  final String buktiPembayaran;
  final Customer nama;
  final List<Alamat> alamat;
  final List<DetailPemesanan> detailPemesanan;

  ConfirmOrder({
    required this.id,
    required this.idCustomer,
    required this.tanggalPemesanan,
    required this.tanggalPembayaran,
    required this.tanggalDiambil,
    required this.jarakDelivery,
    required this.ongkir,
    required this.poinPesanan,
    required this.potonganPoin,
    required this.statusPesanan,
    this.uangCustomer,
    this.tip,
    required this.idAlamat,
    required this.noNota,
    required this.buktiPembayaran,
    required this.nama,
    required this.alamat,
    required this.detailPemesanan,
  });

  factory ConfirmOrder.fromJson(Map<String, dynamic> json) {
    return ConfirmOrder(
      id: json['id'],
      idCustomer: json['id_customer'],
      tanggalPemesanan: json['tanggal_pemesanan'],
      tanggalPembayaran: json['tanggal_pembayaran'],
      tanggalDiambil: json['tanggal_diambil'],
      jarakDelivery: json['jarak_delivery'],
      ongkir: json['ongkir'],
      poinPesanan: json['poin_pesanan'],
      potonganPoin: json['potongan_poin'],
      statusPesanan: json['status_pesanan'],
      uangCustomer: json['uang_customer']?.toDouble(),
      tip: json['tip']?.toDouble(),
      idAlamat: json['id_alamat'],
      noNota: json['no_nota'],
      buktiPembayaran: json['bukti_pembayaran'],
      nama: Customer.fromJson(json['nama']),
      alamat: (json['alamat'] as List).map((e) => Alamat.fromJson(e)).toList(),
      detailPemesanan: (json['detail_pemesanan'] as List)
          .map((e) => DetailPemesanan.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_customer': idCustomer,
      'tanggal_pemesanan': tanggalPemesanan,
      'tanggal_pembayaran': tanggalPembayaran,
      'tanggal_diambil': tanggalDiambil,
      'jarak_delivery': jarakDelivery,
      'ongkir': ongkir,
      'poin_pesanan': poinPesanan,
      'potongan_poin': potonganPoin,
      'status_pesanan': statusPesanan,
      'uang_customer': uangCustomer,
      'tip': tip,
      'id_alamat': idAlamat,
      'no_nota': noNota,
      'bukti_pembayaran': buktiPembayaran,
      'nama': nama.toJson(),
      'alamat': alamat.map((e) => e.toJson()).toList(),
      'detail_pemesanan': detailPemesanan.map((e) => e.toJson()).toList(),
    };
  }
}

class Customer {
  final int id;
  final int idSaldo;
  final String nama;
  final String password;
  final String email;
  final String noTelpn;
  final String tanggalLahir;
  final String? gender;
  final String poin;

  Customer({
    required this.id,
    required this.idSaldo,
    required this.nama,
    required this.password,
    required this.email,
    required this.noTelpn,
    required this.tanggalLahir,
    this.gender,
    required this.poin,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      idSaldo: json['id_saldo'],
      nama: json['nama'],
      password: json['password'],
      email: json['email'],
      noTelpn: json['no_telpn'],
      tanggalLahir: json['tanggal_lahir'],
      gender: json['gender'],
      poin: json['poin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_saldo': idSaldo,
      'nama': nama,
      'password': password,
      'email': email,
      'no_telpn': noTelpn,
      'tanggal_lahir': tanggalLahir,
      'gender': gender,
      'poin': poin,
    };
  }
}

class Alamat {
  final int id;
  final int idCustomer;
  final String namaAlamat;

  Alamat({
    required this.id,
    required this.idCustomer,
    required this.namaAlamat,
  });

  factory Alamat.fromJson(Map<String, dynamic> json) {
    return Alamat(
      id: json['id'],
      idCustomer: json['id_customer'],
      namaAlamat: json['nama_alamat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_customer': idCustomer,
      'nama_alamat': namaAlamat,
    };
  }
}

class DetailPemesanan {
  final int id;
  final int idProduk;
  final int? idHampers;
  final int idPemesanan;
  final int subtotal;
  final int jumlah;
  final String status;
  final Produk produk;

  DetailPemesanan({
    required this.id,
    required this.idProduk,
    this.idHampers,
    required this.idPemesanan,
    required this.subtotal,
    required this.jumlah,
    required this.status,
    required this.produk,
  });

  factory DetailPemesanan.fromJson(Map<String, dynamic> json) {
    return DetailPemesanan(
      id: json['id'],
      idProduk: json['id_produk'],
      idHampers: json['id_hampers'],
      idPemesanan: json['id_pemesanan'],
      subtotal: json['subtotal'],
      jumlah: json['jumlah'],
      status: json['status'],
      produk: Produk.fromJson(json['produk']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_produk': idProduk,
      'id_hampers': idHampers,
      'id_pemesanan': idPemesanan,
      'subtotal': subtotal,
      'jumlah': jumlah,
      'status': status,
      'produk': produk.toJson(),
    };
  }
}

// class Produk {
//   final int id;
//   final int idPenitip;
//   final int? idResep;
//   final DateTime tanggalPenitipan;
//   final String namaProduk;
//   final String gambar;
//   final String deskripsi;
//   final String kategori;
//   final int harga;
//   final int stok;
//   final int status;

//   Produk({
//     required this.id,
//     required this.idPenitip,
//     this.idResep,
//     required this.tanggalPenitipan,
//     required this.namaProduk,
//     required this.gambar,
//     required this.deskripsi,
//     required this.kategori,
//     required this.harga,
//     required this.stok,
//     required this.status,
//   });

//   factory Produk.fromJson(Map<String, dynamic> json) {
//     return Produk(
//       id: json['id'],
//       idPenitip: json['id_penitip'],
//       idResep: json['id_resep'],
//       tanggalPenitipan: DateTime.parse(json['tanggal_penitipan']),
//       namaProduk: json['nama_produk'],
//       gambar: json['gambar'],
//       deskripsi: json['deskripsi'],
//       kategori: json['kategori'],
//       harga: json['harga'],
//       stok: json['stok'],
//       status: json['status'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'id_penitip': idPenitip,
//       'id_resep': idResep,
//       'tanggal_penitipan': tanggalPenitipan.toIso8601String(),
//       'nama_produk': namaProduk,
//       'gambar': gambar,
//       'deskripsi': deskripsi,
//       'kategori': kategori,
//       'harga': harga,
//       'stok': stok,
//       'status': status,
//     };
//   }
// }

class Produk {
  final int? id_penitip, id_resep, harga, stok;
  final DateTime? tanggal_penitipan;
  final String nama_produk, gambar, deskripsi, kategori;
  final int? status;

  Produk({
    this.id_penitip,
    required this.id_resep,
    required this.harga,
    required this.stok,
    required this.tanggal_penitipan,
    required this.nama_produk,
    required this.gambar,
    required this.deskripsi,
    required this.kategori,
    required this.status,
  });

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
    };
  }
}
