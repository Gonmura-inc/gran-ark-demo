# プロジェクト構造

## ルートディレクトリ
```
gran_ark_demo/
├── lib/                 # Dartソースコード
│   ├── main.dart       # アプリケーションエントリーポイント
│   ├── models/         # データモデル定義
│   ├── screens/        # 画面コンポーネント
│   └── data/           # データ層（ダミーデータ等）
├── web/                # Web固有の設定
│   ├── index.html      # HTMLエントリーポイント
│   ├── manifest.json   # PWA設定
│   └── icons/          # アプリアイコン
├── pubspec.yaml        # Flutter依存関係定義
├── firebase.json       # Firebase設定
├── analysis_options.yaml # Dart解析設定
├── CLAUDE.md           # AI運用ガイドライン
└── hojokin.md          # 補助金申請用技術説明資料
```

## 主要モデル
- **Customer**: 顧客情報管理
- **Deal**: 商談・案件情報管理

## 主要画面
- **DashboardScreen**: メインダッシュボード
- **CustomerDetailScreen**: 顧客詳細画面
- **AddCustomerScreen**: 顧客追加画面
- **AddDealScreen**: 案件追加画面