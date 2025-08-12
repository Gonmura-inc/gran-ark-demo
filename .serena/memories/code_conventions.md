# コード規約とスタイル

## Dart/Flutterコーディング規約
- **Linter**: flutter_lints/flutter.yaml を使用
- **静的解析**: `flutter analyze` でエラーチェック

## UI/UXデザイン
- **ブランドカラー**: 
  - プライマリ: ティールブルー (#2E7D8A)
  - セカンダリ: 温かいオレンジ (#FF8A65)
- **カードデザイン**: 角丸16px、elevation 8
- **レスポンシブ対応**: モバイル（<768px）、タブレット（768-1024px）、デスクトップ（>1024px）

## ファイル構造
```
lib/
├── main.dart           # エントリーポイント
├── models/            # データモデル
│   ├── customer.dart
│   └── deal.dart
├── screens/           # 画面コンポーネント
│   ├── dashboard_screen.dart
│   ├── customer_detail_screen.dart
│   └── add_*.dart
└── data/             # データ層
    └── dummy_data.dart
```

## 命名規則
- クラス名: PascalCase（例: GranArkApp）
- ファイル名: snake_case（例: dashboard_screen.dart）
- 変数・関数名: camelCase