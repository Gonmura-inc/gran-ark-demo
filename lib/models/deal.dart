/// 商談履歴データモデル
/// 営業支援システムで使用する商談情報を管理します
class Deal {
  final String id; // 商談ID
  final String customerId; // 顧客ID（関連する顧客）
  final DateTime date; // 商談日
  final String memo; // 商談内容のメモ
  final String staff; // 担当スタッフ
  final String status; // ステータス（対応中、完了、保留など）

  Deal({
    required this.id,
    required this.customerId,
    required this.date,
    required this.memo,
    required this.staff,
    required this.status,
  });

  /// JSONからDealオブジェクトを作成
  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'],
      customerId: json['customerId'],
      date: DateTime.parse(json['date']),
      memo: json['memo'],
      staff: json['staff'],
      status: json['status'],
    );
  }

  /// DealオブジェクトをJSONに変換
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'date': date.toIso8601String(),
      'memo': memo,
      'staff': staff,
      'status': status,
    };
  }
}
