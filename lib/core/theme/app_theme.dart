import 'package:flutter/material.dart';
import 'package:online_exam/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData generalTheme = ThemeData(
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      // foregroundColor: AppColors.blue,
      elevation: 0,
      actionsIconTheme: IconThemeData(
        color: AppColors.black,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 20,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: AppColors.black,
          padding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          textStyle: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(color: AppColors.black
      ,fontSize: 14),
      hintStyle: const TextStyle(color: Colors.grey , fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.gray, width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.gray, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.blue, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.red, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        side: BorderSide(width: 1, color: AppColors.blue),
        fixedSize: Size(343, 48),
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal:24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        elevation: 4, // ممكن تغير قيمة الارتفاع حسب الرغبة
      ),
    ),
  );
}
