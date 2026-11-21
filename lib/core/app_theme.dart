import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app_colors.dart';
import 'app_strings.dart';

class AppTheme {
  // "جرس" بيرن كل ما تغيّر الوضع، والـ MaterialApp بيسمعه وبيعيد الرسم
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(
    Hive.box(AppStrings.settingsBox).get(AppStrings.isDarkKey, defaultValue: false)
        ? ThemeMode.dark
        : ThemeMode.light,
  );

  static bool get isDark => mode.value == ThemeMode.dark;

  static void toggle() {
    mode.value = isDark ? ThemeMode.light : ThemeMode.dark;
    Hive.box(AppStrings.settingsBox).put(AppStrings.isDarkKey, isDark); // نتذكّر الاختيار
  }

  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF242424),
    ),
  );
}
