import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../core/app_colors.dart';
import '../core/app_strings.dart';
import '../core/app_theme.dart';
import '../core/image_helper.dart';
import '../models/user_model.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/main_button.dart';
import '../widgets/user_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Box<UserModel> get box => Hive.box<UserModel>(AppStrings.userBox);

  void saveUser({String? name, String? image}) {
    final old = box.get(AppStrings.userKey)!;
    box.put(
      AppStrings.userKey,
      UserModel(name: name ?? old.name, image: image ?? old.image),
    );
  }

  void showImageSheet(BuildContext context) {
    Future<void> pick(ImageSource source) async {
      Navigator.pop(context);
      final path = await ImageHelper.pick(source);
      if (path != null) saveUser(image: path);
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MainButton(
              text: 'Upload From Camera',
              onPressed: () => pick(ImageSource.camera),
            ),
            const SizedBox(height: 12),
            MainButton(
              text: 'Upload From Gallery',
              onPressed: () => pick(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  void showNameSheet(BuildContext context, String currentName) {
    final controller = TextEditingController(text: currentName);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, 20 + MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(hint: 'Enter your name', controller: controller),
            const SizedBox(height: 16),
            MainButton(
              text: 'Update Your Name',
              onPressed: () {
                final name = controller.text.trim();
                if (name.isNotEmpty) saveUser(name: name);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: AppTheme.mode,
            builder: (context, mode, _) => IconButton(
              icon: Icon(
                mode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                color: AppColors.primary,
              ),
              onPressed: AppTheme.toggle,
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          final user = box.get(AppStrings.userKey);
          if (user == null) return const SizedBox();

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => showImageSheet(context),
                    child: Stack(
                      children: [
                        UserAvatar(imagePath: user.image, radius: 70),
                        const Positioned(
                          bottom: 4,
                          right: 4,
                          child: Icon(Icons.camera_alt,
                              color: AppColors.primary, size: 28),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(color: AppColors.primary),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          user.name,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton.outlined(
                        style: IconButton.styleFrom(
                          side: const BorderSide(color: AppColors.primary),
                        ),
                        icon: const Icon(Icons.edit, color: AppColors.primary),
                        onPressed: () => showNameSheet(context, user.name),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
