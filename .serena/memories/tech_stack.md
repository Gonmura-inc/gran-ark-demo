# 技術スタック

## フロントエンド
- **Flutter Web**: バージョン 3.32.4 (stable)
- **Dart**: バージョン 3.8.1
- **UI Framework**: Material Design 3

## バックエンド・インフラ
- **Firebase Hosting**: 静的ホスティング、CDN配信
- **データ保存**: 現在はLocal Storage（デモ版）、将来的にFirebase/Supabase連携予定

## 開発ツール
- **Linter**: flutter_lints 5.0.0
- **IDE**: VS Code + Flutter拡張推奨

## デプロイ設定
- **Firebase設定**: firebase.json
- **ビルドディレクトリ**: build/web
- **SPAルーティング**: 全URLをindex.htmlにリライト