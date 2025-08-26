class TransactionData {
  final String uuid;
  final String wallet;
  final String name;
  final String desc;
  final int amount;
  final int type;
  final String date;
  final String createdAt;
  final String updatedAt;

  TransactionData({
    required this.uuid,
    required this.wallet,
    required this.name,
    required this.desc,
    required this.amount,
    required this.type,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      uuid: json['uuid'] ?? '',
      wallet: json['wallet'] ?? '',
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
      amount: json['amount'] ?? 0,
      type: json['type'] ?? 0,
      date: json['date'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
