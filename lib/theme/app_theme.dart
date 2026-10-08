import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF0F766E);
  static const background = Color(0xFFF4F7F6);
  static const card = Colors.white;
  static const textDark = Color(0xFF1F2937);
  static const textMuted = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);

  static const completed = Color(0xFF16A34A);
  static const overdue = Color(0xFFDC2626);
  static const atRisk = Color(0xFFF59E0B);
  static const onTrack = Color(0xFF2563EB);
}

class AppSpacing {
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.textDark),
        bodySmall: TextStyle(fontSize: 12, color: AppColors.textMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}