import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import '../core/app_colors.dart';
import '../core/app_strings.dart';
import '../models/user_model.dart';
import 'auth_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final hasUser = Hive.box<UserModel>(AppStrings.userBox)
          .containsKey(AppStrings.userKey);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              hasUser ? const HomeScreen() : const AuthScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/task_icon.json',
              width: 200,
              errorBuilder: (context, error, stack) =>
                  Image.asset('assets/images/logo.png', width: 130),
            ),
            const SizedBox(height: 20),
            const Text(
              'Taskati',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            const Text(
              "It's Time to Get Organized",
              style: TextStyle(fontSize: 15, color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
