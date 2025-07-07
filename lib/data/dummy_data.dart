import '../models/customer.dart';
import '../models/deal.dart';

/// ダミーデータクラス
/// デモ用の顧客データと商談履歴データを提供します
class DummyData {
  /// ダミー顧客データ
  static List<Customer> customers = [
    Customer(
      id: 'cus001',
      name: '山田 太郎',
      email: 'taro.yamada@example.com',
      phone: '090-1234-5678',
      status: '見込み客',
      lastUpdated: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Customer(
      id: 'cus002',
      name: '佐藤 花子',
      email: 'hanako.sato@example.com',
      phone: '090-2345-6789',
      status: '既存客',
      lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Customer(
      id: 'cus003',
      name: '田中 次郎',
      email: 'jiro.tanaka@example.com',
      phone: '090-3456-7890',
      status: '見込み客',
      lastUpdated: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Customer(
      id: 'cus004',
      name: '鈴木 美香',
      email: 'mika.suzuki@example.com',
      phone: '090-4567-8901',
      status: '商談中',
      lastUpdated: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Customer(
      id: 'cus005',
      name: '高橋 和也',
      email: 'kazuya.takahashi@example.com',
      phone: '090-5678-9012',
      status: '契約済み',
      lastUpdated: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Customer(
      id: 'cus006',
      name: '渡辺 真理',
      email: 'mari.watanabe@example.com',
      phone: '090-6789-0123',
      status: '見込み客',
      lastUpdated: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Customer(
      id: 'cus007',
      name: '伊藤 健太',
      email: 'kenta.ito@example.com',
      phone: '090-7890-1234',
      status: '商談中',
      lastUpdated: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Customer(
      id: 'cus008',
      name: '中村 由美',
      email: 'yumi.nakamura@example.com',
      phone: '090-8901-2345',
      status: '既存客',
      lastUpdated: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  /// ダミー商談履歴データ
  static List<Deal> deals = [
    Deal(
      id: 'deal001',
      customerId: 'cus001',
      date: DateTime.now().subtract(const Duration(days: 1)),
      memo: '初回面談実施。賃貸マンションの内見希望。ペット可の物件を探している。予算は月額10万円以内。',
      staff: '吉田 光輝',
      status: '対応中',
    ),
    Deal(
      id: 'deal002',
      customerId: 'cus002',
      date: DateTime.now().subtract(const Duration(days: 3)),
      memo: '契約更新の相談。現在の物件の家賃交渉について。近隣の相場確認を依頼。',
      staff: '田村 雅子',
      status: '完了',
    ),
    Deal(
      id: 'deal003',
      customerId: 'cus001',
      date: DateTime.now().subtract(const Duration(days: 5)),
      memo: 'ペット可物件3件の資料送付。来週内見予定。',
      staff: '吉田 光輝',
      status: '対応中',
    ),
    Deal(
      id: 'deal004',
      customerId: 'cus003',
      date: DateTime.now().subtract(const Duration(days: 2)),
      memo: '転勤に伴う住み替え相談。3LDKの分譲マンション購入希望。予算3000万円。',
      staff: '佐々木 勇',
      status: '商談中',
    ),
    Deal(
      id: 'deal005',
      customerId: 'cus004',
      date: DateTime.now().subtract(const Duration(hours: 6)),
      memo: '物件内見実施。気に入った様子。契約条件の調整中。',
      staff: '山本 恵',
      status: '商談中',
    ),
    Deal(
      id: 'deal006',
      customerId: 'cus005',
      date: DateTime.now().subtract(const Duration(days: 12)),
      memo: '契約締結完了。鍵の引き渡し日程調整。',
      staff: '松井 健',
      status: '完了',
    ),
    Deal(
      id: 'deal007',
      customerId: 'cus006',
      date: DateTime.now().subtract(const Duration(days: 4)),
      memo: '新築一戸建て購入検討。住宅ローンの事前審査申込み。',
      staff: '木村 智子',
      status: '対応中',
    ),
    Deal(
      id: 'deal008',
      customerId: 'cus007',
      date: DateTime.now().subtract(const Duration(hours: 8)),
      memo: '投資用マンション購入相談。利回り8%以上の物件を希望。',
      staff: '中島 正樹',
      status: '商談中',
    ),
  ];

  /// 特定の顧客に関連する商談履歴を取得
  static List<Deal> getDealsForCustomer(String customerId) {
    return deals.where((deal) => deal.customerId == customerId).toList();
  }

  /// 顧客IDから顧客情報を取得
  static Customer? getCustomerById(String customerId) {
    try {
      return customers.firstWhere((customer) => customer.id == customerId);
    } catch (e) {
      return null;
    }
  }

  /// ステータス別の顧客数を取得
  static Map<String, int> getCustomerStatusCount() {
    final statusCount = <String, int>{};
    for (final customer in customers) {
      statusCount[customer.status] = (statusCount[customer.status] ?? 0) + 1;
    }
    return statusCount;
  }

  /// 最近の商談履歴を取得（最新5件）
  static List<Deal> getRecentDeals() {
    final sortedDeals = List<Deal>.from(deals);
    sortedDeals.sort((a, b) => b.date.compareTo(a.date));
    return sortedDeals.take(5).toList();
  }
}
