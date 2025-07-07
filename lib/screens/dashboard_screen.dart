import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../models/deal.dart';
import '../data/dummy_data.dart';
import 'customer_detail_screen.dart';
import 'add_customer_screen.dart';
import 'add_deal_screen.dart';

/// ダッシュボード画面
/// 営業支援システムのメイン画面です
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Customer> customers = DummyData.customers;
  final List<Deal> recentDeals = DummyData.getRecentDeals();
  final Map<String, int> statusCount = DummyData.getCustomerStatusCount();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 温かみのあるグラデーション背景のAppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E7D8A), Color(0xFF4DB6AC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.business_center, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text('GRAN ARK 営業支援システム'),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8F9FB), Color(0xFFF1F5F9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ウェルカムメッセージ
              _buildWelcomeCard(),
              const SizedBox(height: 24),

              // ステータスサマリー
              _buildStatusSummary(),
              const SizedBox(height: 24),

              // 最近の商談履歴
              _buildRecentDeals(),
              const SizedBox(height: 24),

              // 顧客一覧
              _buildCustomerList(),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF8A65), Color(0xFFFFAB91)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF8A65).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => _navigateToAddCustomer(context),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Icons.person_add_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }

  /// ウェルカムカード
  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFECE6), Color(0xFFFFF3E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8A65),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.waving_hand,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'おかえりなさい！',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF2E3D49),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '今日も素晴らしい一日にしましょう ✨',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF546E7A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ステータスサマリーWidget
  Widget _buildStatusSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D8A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '顧客ステータス',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: statusCount.entries.map((entry) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(entry.key),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: _getStatusBorderColor(entry.key),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(entry.key),
                      size: 16,
                      color: _getStatusTextColor(entry.key),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${entry.key}: ${entry.value}件',
                      style: TextStyle(
                        color: _getStatusTextColor(entry.key),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// 最近の商談履歴Widget
  Widget _buildRecentDeals() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8A65),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.history_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '最近の商談履歴',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...recentDeals.map((deal) => _buildDealCard(deal)),
        ],
      ),
    );
  }

  /// 商談カードWidget
  Widget _buildDealCard(Deal deal) {
    final customer = DummyData.getCustomerById(deal.customerId);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECF0), width: 1),
      ),
      child: InkWell(
        onTap: () {
          if (customer != null) {
            _navigateToCustomerDetail(context, customer);
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF2E7D8A),
                  radius: 20,
                  child: Text(
                    customer?.name.substring(0, 1) ?? '？',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer?.name ?? '不明',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF2E3D49),
                        ),
                      ),
                      Text(
                        '${deal.staff} • ${_formatDate(deal.date)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF546E7A),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(deal.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    deal.status,
                    style: TextStyle(
                      color: _getStatusTextColor(deal.status),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              deal.memo,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF37474F),
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// 顧客一覧Widget
  Widget _buildCustomerList() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.people_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '顧客一覧',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8A65), Color(0xFFFFAB91)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton.icon(
                  onPressed: () => _navigateToAddDeal(context),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('商談記録'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...customers.map((customer) => _buildCustomerCard(customer)),
        ],
      ),
    );
  }

  /// 顧客カードWidget
  Widget _buildCustomerCard(Customer customer) {
    final customerDeals = DummyData.getDealsForCustomer(customer.id);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECF0), width: 1),
      ),
      child: InkWell(
        onTap: () => _navigateToCustomerDetail(context, customer),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF2E7D8A),
              radius: 24,
              child: Text(
                customer.name.substring(0, 1),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF2E3D49),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    customer.email,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF546E7A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '商談履歴: ${customerDeals.length}件',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _getStatusColor(customer.status),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                customer.status,
                style: TextStyle(
                  color: _getStatusTextColor(customer.status),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ステータスに応じた色を取得（可愛い色に変更）
  Color _getStatusColor(String status) {
    switch (status) {
      case '見込み客':
        return const Color(0xFFFFF3C4); // 温かい黄色
      case '商談中':
        return const Color(0xFFFFE0B2); // 優しいオレンジ
      case '既存客':
        return const Color(0xFFC8E6C9); // 優しい緑
      case '契約済み':
        return const Color(0xFFBBDEFB); // 優しい青
      case '対応中':
        return const Color(0xFFE1BEE7); // 優しい紫
      case '完了':
        return const Color(0xFFC8E6C9); // 優しい緑
      default:
        return const Color(0xFFF5F5F5); // グレー
    }
  }

  /// ステータスに応じたテキスト色を取得
  Color _getStatusTextColor(String status) {
    switch (status) {
      case '見込み客':
        return const Color(0xFFF57F17); // 濃い黄色
      case '商談中':
        return const Color(0xFFE65100); // 濃いオレンジ
      case '既存客':
        return const Color(0xFF2E7D32); // 濃い緑
      case '契約済み':
        return const Color(0xFF1565C0); // 濃い青
      case '対応中':
        return const Color(0xFF7B1FA2); // 濃い紫
      case '完了':
        return const Color(0xFF2E7D32); // 濃い緑
      default:
        return const Color(0xFF616161); // 濃いグレー
    }
  }

  /// ステータスに応じたボーダー色を取得
  Color _getStatusBorderColor(String status) {
    return _getStatusTextColor(status).withOpacity(0.3);
  }

  /// ステータスに応じたアイコンを取得
  IconData _getStatusIcon(String status) {
    switch (status) {
      case '見込み客':
        return Icons.visibility_rounded;
      case '商談中':
        return Icons.handshake_rounded;
      case '既存客':
        return Icons.person_rounded;
      case '契約済み':
        return Icons.check_circle_rounded;
      case '対応中':
        return Icons.pending_actions_rounded;
      case '完了':
        return Icons.task_alt_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  /// 日付フォーマット
  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}';
  }

  /// 顧客詳細画面に遷移
  void _navigateToCustomerDetail(BuildContext context, Customer customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerDetailScreen(customer: customer),
      ),
    );
  }

  /// 顧客追加画面に遷移
  void _navigateToAddCustomer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCustomerScreen()),
    );
  }

  /// 商談記録追加画面に遷移
  void _navigateToAddDeal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDealScreen()),
    );
  }
}
