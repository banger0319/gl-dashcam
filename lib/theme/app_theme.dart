import 'app_colors.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    const fadeThrough = FadeThroughPageTransitionsBuilder(
      fillColor: Colors.transparent,
    );
    return ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          // Material Motion fade-through: 层级切换更干净，避免「老式」全屏硬切。
          TargetPlatform.android: fadeThrough,
          TargetPlatform.fuchsia: fadeThrough,
          TargetPlatform.linux: fadeThrough,
          TargetPlatform.windows: fadeThrough,
          // 保留 Cupertino 推入与边缘返回手势，符合平台习惯。
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.bgPrimary,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.bgPrimary,
        error: AppColors.danger,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 32,
          height: 40 / 32,
          color: AppColors.textPrimary,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 32,
          height: 40 / 32,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
          height: 32 / 24,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 28 / 20,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          height: 24 / 18,
          color: AppColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 24 / 16,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 24 / 16,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          height: 22 / 15,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          height: 16 / 12,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 20 / 14,
          color: AppColors.textPrimary,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          height: 16 / 12,
          color: AppColors.textSecondary,
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 10,
          height: 14 / 10,
          color: AppColors.textTertiary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.bgSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.borderDefault),
        ),
      ),
    );
  }
}
