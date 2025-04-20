import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondaryPurple,
      tertiary: AppColors.secondaryGreen,
      error: AppColors.error,
      background: AppColors.neutral10,
      onBackground: AppColors.neutral80,
      surface: AppColors.neutral20,
      onSurface: AppColors.neutral80,
      onPrimary: AppColors.neutral10,
      onSecondary: AppColors.neutral10,
      onError: AppColors.neutral10,
      onSurfaceVariant: AppColors.neutral60,
    ),
    scaffoldBackgroundColor: AppColors.neutral10,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.neutral10,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.neutral100,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.neutral80,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: AppColors.neutral60,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.neutral10,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: AppColors.neutral20,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondaryPurple,
      tertiary: AppColors.darkSecondaryGreen,
      error: AppColors.darkError,
      background: AppColors.darkNeutral90,
      onBackground: AppColors.darkNeutral10,
      surface: AppColors.darkNeutral80,
      onSurface: AppColors.darkNeutral20,
      onPrimary: AppColors.darkNeutral90,
      onSecondary: AppColors.darkNeutral90,
      onError: AppColors.darkNeutral90,
      onSurfaceVariant: AppColors.darkNeutral40,
    ),
    scaffoldBackgroundColor: AppColors.darkNeutral90,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.darkNeutral10,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.darkNeutral10,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.darkNeutral20,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: AppColors.darkNeutral40,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkNeutral10,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkPrimary,
        side: BorderSide(color: AppColors.darkPrimary),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: AppColors.darkNeutral80,
    ),
  );
}