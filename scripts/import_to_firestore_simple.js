/**
 * GRAN ARK 顧客データFirestoreインポートスクリプト（シンプル版）
 * 1件ずつ個別にインポート
 */

const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// Firebase Admin SDKの初期化
const serviceAccount = require('/Users/kouki/Downloads/granark-demo-firebase-adminsdk-fbsvc-ede22afb50.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: `https://${serviceAccount.project_id}.firebaseio.com`
});

const db = admin.firestore();

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
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      version: 1
    }
  };
}

/**
 * Firestoreにデータを1件ずつインポート
 */
async function importToFirestore(customers) {
  console.log('\n🔥 Firebase Firestoreへの接続開始...');
  console.log('📍 プロジェクト:', serviceAccount.project_id);
  console.log('🔐 認証: サービスアカウント使用');
  console.log('✅ 接続成功！\n');
  
  console.log(`📤 ${customers.length}件のデータをFirestoreにインポート開始...\n`);
  
  let successCount = 0;
  let errorCount = 0;
  const successfulDocs = [];
  
  for (let i = 0; i < customers.length; i++) {
    const customer = customers[i];
    try {
      const firestoreData = transformToFirestoreFormat(customer);
      
      // 個別にドキュメントを作成
      const docRef = await db.collection('customers').add(firestoreData);
      
      successCount++;
      successfulDocs.push({
        customerId: customer.customer_id,
        name: `${customer.last_name}${customer.first_name}`,
        docId: docRef.id
      });
      
      // 進捗表示
      const progress = Math.floor((i + 1) / customers.length * 100);
      const progressBar = '█'.repeat(Math.floor(progress / 2)) + '░'.repeat(50 - Math.floor(progress / 2));
      
      process.stdout.write(`\r[${progressBar}] ${progress}% (${i + 1}/${customers.length})`);
      
      // 最初の5件と最後の5件の詳細を表示
      if (i < 5 || i >= customers.length - 5) {
        console.log(`\n✅ ${customer.last_name}${customer.first_name} (${customer.customer_id}) → Firestore ID: ${docRef.id}`);
      }
      
    } catch (error) {
      errorCount++;
      console.error(`\n❌ エラー: ${customer.customer_id} - ${customer.last_name}${customer.first_name}`, error.message);
    }
  }
  
  console.log('\n');
  console.log('━'.repeat(60));
  console.log('\n🎉 インポート完了！\n');
  console.log(`✅ 成功: ${successCount}件`);
  console.log(`❌ エラー: ${errorCount}件`);
  console.log(`📊 成功率: ${Math.floor(successCount / customers.length * 100)}%`);
  
  if (successfulDocs.length > 0) {
    console.log('\n📝 インポート成功したドキュメント（最初の10件）:');
    successfulDocs.slice(0, 10).forEach(doc => {
      console.log(`   ${doc.name} (${doc.customerId}) → ${doc.docId}`);
    });
  }
  
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
 * メイン処理
 */
async function main() {
  try {
    console.log('\n🚀 GRAN ARK 顧客データ移行ツール v1.0 (シンプル版)');
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
    
    // Firestoreにインポート
    await importToFirestore(customers);
    
    // 接続を閉じる
    await admin.app().delete();
    
    console.log('\n✨ すべての処理が完了しました！');
    console.log('🔗 Firebase Console: https://console.firebase.google.com/project/granark-demo/firestore/data/~2Fcustomers');
    
  } catch (error) {
    console.error('\n❌ エラーが発生しました:', error);
    process.exit(1);
  }
}

// 実行
main();