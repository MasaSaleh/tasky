import 'package:flutter/material.dart';

// كل ألوان التطبيق بمكان واحد (نفس فكرة AppStrings)
class AppColors {
  static const Color primary = Color(0xFF4E5AE8); // الأزرق الأساسي
  static const Color orange = Color(0xFFFF8746);
  static const Color pink = Color(0xFFFF4667);
  static const Color green = Color(0xFF4CAF50); // خلفية سحب "Complete"
  static const Color red = Color(0xFFF44336); // خلفية سحب "Delete"
  static const Color grey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF333333); // دائرة الصورة الافتراضية
  static const Color darkBackground = Color(0xFF181818);

  // ألوان المهام اللي بيختار منها المستخدم (الترتيب مهم: بنخزّن الرقم)
  static const List<Color> taskColors = [primary, pink, orange];
}
