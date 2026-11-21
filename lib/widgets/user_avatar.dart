import 'dart:io';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// صورة المستخدم: لو في مسار صورة بنعرضها، لو لا بنعرض الأيقونة الافتراضية
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.imagePath, this.radius = 85});

  final String imagePath; // فاضي = ما في صورة لسا
  final double radius;

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath.isNotEmpty && File(imagePath).existsSync();

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.darkGrey,
      backgroundImage: hasImage ? FileImage(File(imagePath)) : null,
      child: hasImage
          ? null
          : Icon(Icons.person, size: radius * 1.5, color: AppColors.primary),
    );
  }
}
