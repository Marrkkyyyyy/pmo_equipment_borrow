import 'package:flutter/material.dart';
import 'package:pmo_equipment_borrow/core/theme/app_color.dart';

/// Defines the theme for the PMO Equipment and Office Supplies Inventory System.
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Main theme colors
      primaryColor: AppColor.navyBlue,
      scaffoldBackgroundColor: AppColor.white,

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.navyBlue,
        foregroundColor: AppColor.white,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Manrope",
          fontSize: 22,
          color: AppColor.white,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),

      // Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColor.white,
          backgroundColor: AppColor.tealGreen, // Text color for buttons
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Text theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColor.darkGray,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColor.darkGray,
          fontSize: 14,
        ),
        titleLarge: TextStyle(
          color: AppColor.navyBlue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          color: AppColor.skyBlue,
          fontSize: 12,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.lightGray,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.navyBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.tealGreen),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColor.navyBlue),
        ),
      ),

      // Floating action button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColor.tealGreen,
        foregroundColor: AppColor.white,
      ),

      // Chip theme
      chipTheme: const ChipThemeData(
        backgroundColor: AppColor.lightGray,
        labelStyle: TextStyle(color: AppColor.darkGray),
        secondaryLabelStyle: TextStyle(color: AppColor.white),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),

      // Divider color
      dividerColor: AppColor.lightBlue,

      // Checkbox and Radio button colors
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(AppColor.tealGreen),
        checkColor: WidgetStateProperty.all(AppColor.white),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(AppColor.tealGreen),
      ),

      // Snackbar theme
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColor.navyBlue,
        contentTextStyle: TextStyle(color: AppColor.white),
        actionTextColor: AppColor.skyBlue,
      ),

      fontFamily: 'Manrope',
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: AppColor.tealGreen),
    );
  }
}
