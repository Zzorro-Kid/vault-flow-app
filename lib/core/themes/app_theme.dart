import 'package:flutter/material.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/core/constants/app_dimensions.dart';

class AppTheme {
  static ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required Color scaffoldBackgroundColor,
    required Color appBarBackgroundColor,
    required Color appBarForegroundColor,
    required Color cardColor,
    required Color inputFillColor,
    required Color borderColor,
    required Color primaryColor,
    required Color buttonBackgroundColor,
    required Color buttonForegroundColor,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: _buildAppBarTheme(
        backgroundColor: appBarBackgroundColor,
        foregroundColor: appBarForegroundColor,
      ),
      cardTheme: _buildCardTheme(cardColor),
      elevatedButtonTheme: _buildElevatedButtonTheme(
        backgroundColor: buttonBackgroundColor,
        foregroundColor: buttonForegroundColor,
      ),
      inputDecorationTheme: _buildInputDecorationTheme(
        fillColor: inputFillColor,
        borderColor: borderColor,
        primaryColor: primaryColor,
      ),
    );
  }

  static AppBarTheme _buildAppBarTheme({
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
      centerTitle: true,
    );
  }

  static CardThemeData _buildCardTheme(Color color) {
    return CardThemeData(
      color: color,
      elevation: AppDimensions.elevationSmall,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme({
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
          vertical: AppDimensions.paddingSmall,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
    required Color primaryColor,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        borderSide: const BorderSide(color: AppColors.error),
      ),
    );
  }

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primaryLight,
    secondary: AppColors.accent,
    surface: AppColors.surfaceDark,
    error: AppColors.error,
  );

  static ThemeData get darkTheme => _buildTheme(
    brightness: Brightness.dark,
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarBackgroundColor: AppColors.surfaceDark,
    appBarForegroundColor: AppColors.textPrimaryDark,
    cardColor: AppColors.surfaceDark,
    inputFillColor: AppColors.surfaceDark,
    borderColor: AppColors.borderDark,
    primaryColor: AppColors.primaryLight,
    buttonBackgroundColor: AppColors.primaryLight,
    buttonForegroundColor: AppColors.textPrimaryDark,
  );
}
