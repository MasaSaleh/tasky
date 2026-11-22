import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../core/app_colors.dart';
import '../core/app_strings.dart';
import '../core/image_helper.dart';
import '../models/user_model.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/main_button.dart';
import '../widgets/user_avatar.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final nameController = TextEditingController();
  String imagePath = '';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> pickImage(ImageSource source) async {
    final path = await ImageHelper.pick(source);
    if (path != null) setState(() => imagePath = path);
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void onDone() {
    final name = nameController.text.trim();
    if (imagePath.isEmpty) return showMessage('Please upload your image');
    if (name.isEmpty) return showMessage('Please enter your name');

    Hive.box<UserModel>(AppStrings.userBox).put(
      AppStrings.userKey,
      UserModel(name: name, image: imagePath),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: onDone,
            child: const Text('Done',
                style: TextStyle(color: AppColors.primary, fontSize: 16)),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              UserAvatar(imagePath: imagePath),
              const SizedBox(height: 20),
              MainButton(
                text: 'Upload From Camera',
                width: 260,
                onPressed: () => pickImage(ImageSource.camera),
              ),
              const SizedBox(height: 10),
              MainButton(
                text: 'Upload From Gallery',
                width: 260,
                onPressed: () => pickImage(ImageSource.gallery),
              ),
              const SizedBox(height: 25),
              const Divider(),
              const SizedBox(height: 25),
              CustomTextField(
                hint: 'Enter your name',
                controller: nameController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
