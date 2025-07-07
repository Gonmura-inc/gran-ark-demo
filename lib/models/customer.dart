/// 顧客データモデル
/// 営業支援システムで使用する顧客情報を管理します
class Customer {
  final String id; // 顧客ID
  final String name; // 顧客名
  final String email; // メールアドレス
  final String phone; // 電話番号
  final String status; // ステータス（見込み客、既存客など）
  final DateTime lastUpdated; // 最終更新日

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.lastUpdated,
  });

  /// JSONからCustomerオブジェクトを作成
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  /// CustomerオブジェクトをJSONに変換
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
