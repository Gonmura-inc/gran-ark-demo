#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
GRAN ARK 顧客データ生成スクリプト
補助金申請用のダミー顧客データ（50件）を生成
"""

import csv
import random
import string
from datetime import datetime, timedelta
import json

# 日本人の姓名データ
LAST_NAMES = ['佐藤', '鈴木', '高橋', '田中', '渡辺', '伊藤', '山本', '中村', '小林', '加藤',
              '吉田', '山田', '佐々木', '山口', '松本', '井上', '木村', '林', '斎藤', '清水',
              '山崎', '森', '池田', '橋本', '阿部', '石川', '山下', '中島', '石井', '小川']

FIRST_NAMES_MALE = ['太郎', '次郎', '三郎', '一郎', '健太', '翔太', '大輝', '拓海', '健一', '雄大',
                    '和也', '直樹', '慎一', '隆', '誠', '修', '博', '浩', '茂', '明']

FIRST_NAMES_FEMALE = ['花子', '美咲', '愛', 'さくら', '優子', '真由美', '恵美', '由美子', '陽子', '智子',
                      '裕子', '洋子', '幸子', '和子', '京子', '典子', '順子', '敦子', '久美子', '美穂']

LAST_NAMES_KANA = ['サトウ', 'スズキ', 'タカハシ', 'タナカ', 'ワタナベ', 'イトウ', 'ヤマモト', 'ナカムラ', 'コバヤシ', 'カトウ',
                   'ヨシダ', 'ヤマダ', 'ササキ', 'ヤマグチ', 'マツモト', 'イノウエ', 'キムラ', 'ハヤシ', 'サイトウ', 'シミズ',
                   'ヤマザキ', 'モリ', 'イケダ', 'ハシモト', 'アベ', 'イシカワ', 'ヤマシタ', 'ナカジマ', 'イシイ', 'オガワ']

FIRST_NAMES_MALE_KANA = ['タロウ', 'ジロウ', 'サブロウ', 'イチロウ', 'ケンタ', 'ショウタ', 'ダイキ', 'タクミ', 'ケンイチ', 'ユウダイ',
                         'カズヤ', 'ナオキ', 'シンイチ', 'タカシ', 'マコト', 'オサム', 'ヒロシ', 'ヒロシ', 'シゲル', 'アキラ']

FIRST_NAMES_FEMALE_KANA = ['ハナコ', 'ミサキ', 'アイ', 'サクラ', 'ユウコ', 'マユミ', 'エミ', 'ユミコ', 'ヨウコ', 'トモコ',
                           'ユウコ', 'ヨウコ', 'サチコ', 'カズコ', 'キョウコ', 'ノリコ', 'ジュンコ', 'アツコ', 'クミコ', 'ミホ']

# エリアデータ（東京23区）
TOKYO_WARDS = ['千代田区', '中央区', '港区', '新宿区', '文京区', '台東区', '墨田区', '江東区', '品川区', '目黒区',
               '大田区', '世田谷区', '渋谷区', '中野区', '杉並区', '豊島区', '北区', '荒川区', '板橋区', '練馬区',
               '足立区', '葛飾区', '江戸川区']

# 企業名データ
COMPANY_NAMES = ['株式会社グローバルテック', '株式会社イノベーション', '株式会社フューチャー', '株式会社ネクスト',
                 '株式会社アドバンス', '株式会社プログレス', '株式会社クリエイティブ', '株式会社ソリューション',
                 '東京商事株式会社', '株式会社トータルサービス', '株式会社ビジネスパートナー', '株式会社システムズ',
                 '株式会社コーポレーション', '株式会社エンタープライズ', '株式会社デベロップメント']

# 営業スタッフ名
SALES_STAFF = ['山田花子', '佐藤次郎', '鈴木美咲', '高橋健太', '田中愛']

def generate_customer_id():
    """8桁のランダムな英数字IDを生成"""
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=8))

def generate_phone_number(type='mobile'):
    """電話番号を生成"""
    if type == 'mobile':
        return f"090-{random.randint(1000, 9999)}-{random.randint(1000, 9999)}"
    elif type == 'home':
        return f"03-{random.randint(1000, 9999)}-{random.randint(1000, 9999)}"
    else:  # work or fax
        return f"03-{random.randint(1000, 9999)}-{random.randint(1000, 9999)}"

def generate_email(first_name, last_name):
    """メールアドレスを生成"""
    domains = ['gmail.com', 'yahoo.co.jp', 'outlook.com', 'example.com', 'mail.com']
    patterns = [
        f"{last_name.lower()}.{first_name.lower()}",
        f"{first_name.lower()}.{last_name.lower()}",
        f"{last_name.lower()}{random.randint(1, 99)}",
        f"{first_name[0].lower()}.{last_name.lower()}"
    ]
    pattern = random.choice(patterns)
    domain = random.choice(domains)
    return f"{pattern}@{domain}"

def generate_birth_date():
    """生年月日を生成（25歳〜65歳）"""
    age = random.randint(25, 65)
    today = datetime.now()
    birth_year = today.year - age
    birth_month = random.randint(1, 12)
    birth_day = random.randint(1, 28)  # 簡単のため28日まで
    return f"{birth_year}-{birth_month:02d}-{birth_day:02d}", age

def generate_postal_code():
    """郵便番号を生成"""
    return f"{random.randint(100, 199)}-{random.randint(0, 9999):04d}"

def generate_customer_data(index):
    """1件の顧客データを生成"""
    # 性別を決定
    gender = random.choice(['男性', '女性'])
    
    # 名前を生成
    last_name_idx = random.randint(0, len(LAST_NAMES) - 1)
    last_name = LAST_NAMES[last_name_idx]
    last_name_kana = LAST_NAMES_KANA[last_name_idx]
    
    if gender == '男性':
        first_name_idx = random.randint(0, len(FIRST_NAMES_MALE) - 1)
        first_name = FIRST_NAMES_MALE[first_name_idx]
        first_name_kana = FIRST_NAMES_MALE_KANA[first_name_idx]
    else:
        first_name_idx = random.randint(0, len(FIRST_NAMES_FEMALE) - 1)
        first_name = FIRST_NAMES_FEMALE[first_name_idx]
        first_name_kana = FIRST_NAMES_FEMALE_KANA[first_name_idx]
    
    # その他の情報を生成
    birth_date, age = generate_birth_date()
    email = generate_email(first_name, last_name)
    sub_email = f"{first_name[0].lower()}.{last_name.lower()}@{random.choice(['gmail.com', 'yahoo.co.jp'])}"
    line_id = f"{last_name.lower()}_{first_name.lower()}{random.randint(1, 99)}"
    
    # 住所情報
    ward = random.choice(TOKYO_WARDS)
    street = f"{random.randint(1, 5)}-{random.randint(1, 50)}-{random.randint(1, 20)}"
    buildings = ['', '', 'メゾン○○', 'コーポ○○', '○○マンション', '○○ビル', '○○ハイツ']
    building = random.choice(buildings).replace('○○', random.choice(['サクラ', 'グリーン', 'ブルー', 'ホワイト', 'シティ']))
    if building:
        building += f" {random.randint(101, 1205)}"
    
    # 職業情報
    occupation = random.choice(['会社員', '自営業', '公務員', '会社役員', '医師', '弁護士', '教師', '専門職'])
    industry = random.choice(['IT', '製造業', 'サービス業', '金融', '不動産', '医療', '教育', '小売業', '建設業'])
    income_ranges = ['300万未満', '300-500万', '500-700万', '700-1000万', '1000-1500万', '1500万以上']
    income = random.choice(income_ranges)
    position = random.choice(['一般', '主任', '係長', '課長', '部長', '役員'])
    
    # 不動産情報
    status = random.choice(['見込み客', '商談中', '契約済み', '既存客'])
    property_type = random.choice(['マンション', '一戸建て', '土地', '投資用マンション'])
    budget_ranges = ['3000万未満', '3000-5000万', '5000-7000万', '7000万-1億', '1億-1.5億', '1.5億以上']
    budget = random.choice(budget_ranges)
    layout = random.choice(['1LDK', '2LDK', '3LDK', '4LDK', '5LDK以上'])
    area_size = random.randint(40, 120)
    
    # 営業情報
    acquisition_channels = ['Web問合せ', '電話', '来店', '紹介', 'チラシ', '看板', 'イベント']
    acquisition = random.choice(acquisition_channels)
    
    # 日付情報
    registered_date = datetime.now() - timedelta(days=random.randint(1, 365))
    last_contact = registered_date + timedelta(days=random.randint(1, 30))
    next_action = last_contact + timedelta(days=random.randint(1, 14))
    
    return {
        'customer_id': generate_customer_id(),
        'last_name': last_name,
        'first_name': first_name,
        'last_name_kana': last_name_kana,
        'first_name_kana': first_name_kana,
        'gender': gender,
        'birth_date': birth_date,
        'age': age,
        'customer_type': '個人',
        'registered_date': registered_date.strftime('%Y-%m-%d %H:%M:%S'),
        'email': email,
        'sub_email': sub_email,
        'mobile': generate_phone_number('mobile'),
        'home_phone': generate_phone_number('home') if random.random() > 0.3 else '',
        'work_phone': generate_phone_number('work') if occupation == '会社員' else '',
        'fax': generate_phone_number('fax') if random.random() > 0.7 else '',
        'line_id': line_id if random.random() > 0.4 else '',
        'preferred_contact': random.choice(['メール', '電話', 'LINE', '訪問']),
        'postal_code': generate_postal_code(),
        'prefecture': '東京都',
        'city': ward,
        'street': street,
        'building': building,
        'residence_type': random.choice(['持ち家', '賃貸', '社宅', '実家']),
        'residence_years': random.randint(1, 20),
        'occupation': occupation,
        'company_name': random.choice(COMPANY_NAMES) if occupation == '会社員' else '',
        'industry': industry,
        'annual_income': income,
        'years_employed': random.randint(1, 30),
        'position': position if occupation == '会社員' else '',
        'customer_status': status,
        'property_type': property_type,
        'preferred_area_1': ward,
        'preferred_area_2': random.choice([w for w in TOKYO_WARDS if w != ward]),
        'preferred_area_3': random.choice([w for w in TOKYO_WARDS if w != ward]),
        'budget': budget,
        'preferred_layout': layout,
        'preferred_size': area_size,
        'purchase_timing': random.choice(['即決', '3ヶ月以内', '6ヶ月以内', '1年以内', '未定']),
        'financing_plan': random.choice(['現金', 'ローン', '現金+ローン']),
        'assigned_staff': random.choice(SALES_STAFF),
        'acquisition_channel': acquisition,
        'last_contact_date': last_contact.strftime('%Y-%m-%d'),
        'next_action_date': next_action.strftime('%Y-%m-%d')
    }

def main():
    """メイン処理"""
    # 50件のダミーデータを生成
    customers = []
    for i in range(50):
        customer = generate_customer_data(i)
        customers.append(customer)
    
    # CSVファイルに書き出し
    csv_filename = 'gran_ark_customers.csv'
    with open(csv_filename, 'w', newline='', encoding='utf-8-sig') as csvfile:
        fieldnames = customers[0].keys()
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        
        # ヘッダーを書き込み
        writer.writeheader()
        
        # データを書き込み
        for customer in customers:
            writer.writerow(customer)
    
    print(f"✅ {len(customers)}件の顧客データを{csv_filename}に出力しました")
    
    # JSON形式でも出力（Firestore用）
    json_filename = 'gran_ark_customers.json'
    with open(json_filename, 'w', encoding='utf-8') as jsonfile:
        json.dump(customers, jsonfile, ensure_ascii=False, indent=2)
    
    print(f"✅ JSON形式でも{json_filename}に出力しました")

if __name__ == '__main__':
    main()