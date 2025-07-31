/**
 * GRAN ARK 顧客データFirestoreインポートスクリプト
 * CSVまたはJSONファイルからFirestoreにデータをインポート
 */

const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

// Firebase Admin SDKの初期化
// 注意: 実際の使用時はサービスアカウントキーが必要です
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
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
 * Firestoreにデータをインポート
 */
async function importToFirestore(customers) {
  const batch = db.batch();
  const collectionRef = db.collection('customers');
  
  console.log(`📤 ${customers.length}件のデータをFirestoreにインポート開始...`);
  
  let successCount = 0;
  let errorCount = 0;
  
  for (const customer of customers) {
    try {
      const docRef = collectionRef.doc(); // 自動ID生成
      const firestoreData = transformToFirestoreFormat(customer);
      batch.set(docRef, firestoreData);
      successCount++;
      
      console.log(`✅ ${customer.last_name}${customer.first_name} (${customer.customer_id}) をインポート準備`);
    } catch (error) {
      console.error(`❌ エラー: ${customer.customer_id}`, error);
      errorCount++;
    }
  }
  
  // バッチコミット
  try {
    await batch.commit();
    console.log(`\n🎉 インポート完了！`);
    console.log(`✅ 成功: ${successCount}件`);
    console.log(`❌ エラー: ${errorCount}件`);
  } catch (error) {
    console.error('バッチコミットエラー:', error);
  }
}

/**
 * メイン処理
 */
async function main() {
  try {
    // JSONファイルを読み込み
    const jsonPath = path.join(__dirname, 'gran_ark_customers.json');
    const jsonData = fs.readFileSync(jsonPath, 'utf8');
    const customers = JSON.parse(jsonData);
    
    console.log(`📁 ${customers.length}件の顧客データを読み込みました`);
    
    // Firestoreにインポート
    await importToFirestore(customers);
    
    // 接続を閉じる
    await admin.app().delete();
    console.log('\n✨ 処理が完了しました');
    
  } catch (error) {
    console.error('エラーが発生しました:', error);
    process.exit(1);
  }
}

// 実行
main();