# 推奨コマンド一覧

## 開発コマンド
```bash
# 依存関係インストール
flutter pub get

# アプリ実行（Web版）
flutter run -d chrome

# コード解析（リント）
flutter analyze

# テスト実行
flutter test

# Web版ビルド
flutter build web
```

## Firebase関連
```bash
# Firebase CLIインストール（必要な場合）
npm install -g firebase-tools

# Firebaseログイン
firebase login

# デプロイ
firebase deploy

# ホスティングのみデプロイ
firebase deploy --only hosting
```

## Git操作
```bash
# ステータス確認
git status

# 変更をステージング
git add .

# コミット
git commit -m "メッセージ"

# プッシュ
git push origin main
```

## システムユーティリティ（macOS）
```bash
# ディレクトリ一覧
ls -la

# ファイル検索
find . -name "*.dart"

# テキスト検索（ripgrep推奨）
rg "検索文字列"
```