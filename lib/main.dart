import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/app_strings.dart';
import 'models/user_model.dart';
import 'task_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(AppStrings.userBox);
  await Hive.openBox(AppStrings.settingsBox);
  runApp(const TaskApp());
}
