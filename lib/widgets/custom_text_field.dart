import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.label,
    required this.hint,
    this.controller,
    this.maxLines = 1,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.showHintAsValue = false,
  });

  final String? label;
  final String hint;
  final TextEditingController? controller;
  final int maxLines;
  final IconData? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool showHintAsValue;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.primary),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: showHintAsValue ? textColor : AppColors.grey,
            ),
            suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
