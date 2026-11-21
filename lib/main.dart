import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/app_strings.dart';
import 'models/user_model.dart';
import 'task_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();          // 0. شغّل المحرك واربطه بالواجهة
  await Hive.initFlutter();                           // 1. احجز مكان بالذاكرة
  Hive.registerAdapter(UserModelAdapter());           // 2. سجّل المترجم
  await Hive.openBox<UserModel>(AppStrings.userBox);  // 3. افتح صندوق المستخدم
  await Hive.openBox(AppStrings.settingsBox);         //    وصندوق الإعدادات (الوضع الليلي)
  runApp(const TaskApp());                            // 4. انطلق!
}
