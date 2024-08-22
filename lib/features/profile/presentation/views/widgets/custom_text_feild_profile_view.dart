import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/theme/custom_themes/text_field_theme.dart';

class CustomTextFieldProfileView extends StatelessWidget {
  const CustomTextFieldProfileView({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.inputType,
  });

  final TextEditingController controller;
  final String hintText;
  final Icon prefixIcon;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        enabledBorder:
            QTextFormFieldTheme.lightInputDecorationTheme.enabledBorder,
        focusedBorder:
            QTextFormFieldTheme.lightInputDecorationTheme.focusedBorder,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: QTextFormFieldTheme.lightInputDecorationTheme.hintStyle,
        filled: true,
        fillColor: QColors.white.withOpacity(0.1),
      ),
    );
  }
}
