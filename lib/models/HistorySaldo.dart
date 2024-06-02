class History {
  final int id;
  final int customerId;
  final double saldoAmount;
  final DateTime withdrawalDate;
  final DateTime confirmationDate;
  final String status;

  History({
    required this.id,
    required this.customerId,
    required this.saldoAmount,
    required this.withdrawalDate,
    required this.confirmationDate,
    required this.status,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      customerId: json['id_customer'],
      saldoAmount: json['jumlah_saldo'].toDouble(),
      withdrawalDate: DateTime.parse(json['tanggal_penarikan']),
      confirmationDate: DateTime.parse(json['tanggal_konfirmasi']),
      status: json['status'],
    );
  }
}