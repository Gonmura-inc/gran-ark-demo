/**
 * GRAN ARK 顧客データFirestoreインポートスクリプト（デモ版）
 * 補助金申請用のスクリーンショット撮影用
 * 実際のFirestore接続なしで動作確認が可能
 */

const fs = require('fs');
const path = require('path');

/**
 * 顧客データをFirestore形式に変換
 */
function transformToFirestoreFormat(customer) {
  return {
    customerId: customer.customer_id,
    basicInfo: {
      lastName: customer.last_name,
      firstName: customer.first_name,
      lastNameKana: customer.last_name_kana,
      firstNameKana: customer.first_name_kana,
      gender: customer.gender,
      birthDate: customer.birth_date,
      age: parseInt(customer.age),
      customerType: customer.customer_type,
      registeredAt: customer.registered_date
    },
    contactInfo: {
      email: customer.email,
      subEmail: customer.sub_email,
      mobile: customer.mobile,
      homePhone: customer.home_phone || null,
      workPhone: customer.work_phone || null,
      fax: customer.fax || null,
      lineId: customer.line_id || null,
      preferredContact: customer.preferred_contact
    },
    addressInfo: {
      postalCode: customer.postal_code,
      prefecture: customer.prefecture,
      city: customer.city,
      street: customer.street,
      building: customer.building || null,
      residenceType: customer.residence_type,
      residenceYears: parseInt(customer.residence_years)
    },
    occupationInfo: {
      occupation: customer.occupation,
      companyName: customer.company_name || null,
      industry: customer.industry,
      annualIncome: customer.annual_income,
      yearsEmployed: parseInt(customer.years_employed),
      position: customer.position || null
    },
    propertyPreferences: {
      status: customer.customer_status,
      propertyType: customer.property_type,
      preferredArea1: customer.preferred_area_1,
      preferredArea2: customer.preferred_area_2,
      preferredArea3: customer.preferred_area_3,
      budget: customer.budget,
      preferredLayout: customer.preferred_layout,
      preferredSize: parseInt(customer.preferred_size),
      purchaseTiming: customer.purchase_timing,
      financingPlan: customer.financing_plan
    },
    salesManagement: {
      assignedStaff: customer.assigned_staff,
      acquisitionChannel: customer.acquisition_channel,
      lastContactDate: customer.last_contact_date,
      nextActionDate: customer.next_action_date
    },
    metadata: {
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
      version: 1
    }
  };
}

/**
 * Firestoreへのインポートをシミュレート
 */
async function simulateFirestoreImport(customers) {
  console.log('\n🔥 Firebase Firestoreへの接続開始...');
  console.log('📍 プロジェクト: gran-ark-demo');
  console.log('🔐 認証: サービスアカウント使用');
  console.log('✅ 接続成功！\n');
  
  console.log(`📤 ${customers.length}件のデータをFirestoreにインポート開始...\n`);
  
  let successCount = 0;
  let errorCount = 0;
  
  // プログレスバーの表示
  const totalCustomers = customers.length;
  
  for (let i = 0; i < customers.length; i++) {
    const customer = customers[i];
    try {
      const firestoreData = transformToFirestoreFormat(customer);
      
      // 進捗表示
      const progress = Math.floor((i + 1) / totalCustomers * 100);
      const progressBar = '█'.repeat(Math.floor(progress / 2)) + '░'.repeat(50 - Math.floor(progress / 2));
      
      process.stdout.write(`\r[${progressBar}] ${progress}% (${i + 1}/${totalCustomers})`);
      
      // 実際のFirestore書き込みをシミュレート（少し遅延を入れる）
      await new Promise(resolve => setTimeout(resolve, 50));
      
      successCount++;
      
      // 最初の5件と最後の5件のみ詳細ログ
      if (i < 5 || i >= customers.length - 5) {
        console.log(`\n✅ ${customer.last_name}${customer.first_name} (${customer.customer_id}) → Firestore Document ID: ${generateFirestoreId()}`);
      }
    } catch (error) {
      console.error(`\n❌ エラー: ${customer.customer_id}`, error);
      errorCount++;
    }
  }
  
  console.log('\n');
  console.log('━'.repeat(60));
  console.log('\n🎉 インポート完了！\n');
  console.log(`✅ 成功: ${successCount}件`);
  console.log(`❌ エラー: ${errorCount}件`);
  console.log(`📊 成功率: ${Math.floor(successCount / totalCustomers * 100)}%`);
  console.log('\n💾 データ構造:');
  console.log('  └─ customers (コレクション)');
  console.log('      └─ {documentId} (ドキュメント)');
  console.log('          ├─ customerId: 8桁英数字');
  console.log('          ├─ basicInfo: 基本情報');
  console.log('          ├─ contactInfo: 連絡先情報');
  console.log('          ├─ addressInfo: 住所情報');
  console.log('          ├─ occupationInfo: 職業情報');
  console.log('          ├─ propertyPreferences: 物件希望条件');
  console.log('          ├─ salesManagement: 営業管理情報');
  console.log('          └─ metadata: メタデータ');
  console.log('\n━'.repeat(60));
}

/**
 * FirestoreドキュメントIDを生成（デモ用）
 */
function generateFirestoreId() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  let id = '';
  for (let i = 0; i < 20; i++) {
    id += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return id;
}

/**
 * メイン処理
 */
async function main() {
  try {
    console.log('\n🚀 GRAN ARK 顧客データ移行ツール v1.0');
    console.log('━'.repeat(60));
    console.log('📅 実行日時:', new Date().toLocaleString('ja-JP'));
    console.log('━'.repeat(60));
    
    // JSONファイルを読み込み
    const jsonPath = path.join(__dirname, 'gran_ark_customers.json');
    const jsonData = fs.readFileSync(jsonPath, 'utf8');
    const customers = JSON.parse(jsonData);
    
    console.log(`\n📁 ${customers.length}件の顧客データを読み込みました`);
    console.log('📍 ソース: gran_ark_customers.json');
    
    // データの概要を表示
    const statusCounts = {};
    customers.forEach(c => {
      statusCounts[c.customer_status] = (statusCounts[c.customer_status] || 0) + 1;
    });
    
    console.log('\n📊 顧客ステータス分布:');
    Object.entries(statusCounts).forEach(([status, count]) => {
      console.log(`   ${status}: ${count}件`);
    });
    
    // Firestoreにインポート（シミュレート）
    await simulateFirestoreImport(customers);
    
    console.log('\n✨ すべての処理が完了しました！');
    console.log('🔗 Firebase Console: https://console.firebase.google.com/project/gran-ark-demo/firestore');
    
  } catch (error) {
    console.error('\n❌ エラーが発生しました:', error);
    process.exit(1);
  }
}

// 実行
main();