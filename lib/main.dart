import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const GranArkApp());
}

/// GRAN ARK営業支援システムのメインアプリ
class GranArkApp extends StatelessWidget {
  const GranArkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GRAN ARK 営業支援システム',
      theme: ThemeData(
        // GRAN ARKブランドに合わせた温かみのあるカラーパレット
        primarySwatch: MaterialColor(0xFF2E7D8A, {
          50: const Color(0xFFE0F2F4),
          100: const Color(0xFFB3DDE3),
          200: const Color(0xFF80C6D0),
          300: const Color(0xFF4DAFBD),
          400: const Color(0xFF269DAE),
          500: const Color(0xFF2E7D8A), // メインカラー（落ち着いたティール）
          600: const Color(0xFF29757F),
          700: const Color(0xFF236A73),
          800: const Color(0xFF1D5F67),
          900: const Color(0xFF134C52),
        }),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D8A), // ティールブルー
          brightness: Brightness.light,
          secondary: const Color(0xFFFF8A65), // 温かいオレンジ
          tertiary: const Color(0xFFFFAB91), // ソフトピーチ
          surface: const Color(0xFFFAFAFA),
          background: const Color(0xFFF5F7FA),
        ),

        // 背景色を温かみのあるクリーム色に
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),

        // カードのテーマを可愛くモダンに
        cardTheme: CardThemeData(
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        ),

        // AppBarのテーマを温かみのあるグラデーションに
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xFF2E7D8A),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),

        // ボタンのテーマを可愛くモダンに
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF8A65),
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: const Color(0xFFFF8A65).withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),

        // FloatingActionButtonのテーマ
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF8A65),
          foregroundColor: Colors.white,
          elevation: 8,
        ),

        // Chipのテーマを可愛く
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFFFFECE6),
          labelStyle: const TextStyle(
            color: Color(0xFF5D4037),
            fontWeight: FontWeight.w500,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // TextFormFieldのテーマ
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF2E7D8A), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),

        // テキストテーマを温かみのあるフォントに
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xFF2E3D49),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          titleLarge: TextStyle(
            color: Color(0xFF2E3D49),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          titleMedium: TextStyle(
            color: Color(0xFF2E3D49),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          bodyLarge: TextStyle(color: Color(0xFF37474F), fontSize: 16),
          bodyMedium: TextStyle(color: Color(0xFF546E7A), fontSize: 14),
        ),
      ),
      // 直接ダッシュボード画面から開始
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false, // デバッグバナーを非表示
    );
  }
}
