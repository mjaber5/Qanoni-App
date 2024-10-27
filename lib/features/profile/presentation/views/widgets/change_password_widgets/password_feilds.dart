import 'package:flutter/material.dart';
import '../../../../../../core/widgets/app_text_form_field.dart';

class PasswordFeild extends StatelessWidget {
  const PasswordFeild({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isObscureText,
    required this.toggleObscureText,
    required this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  final VoidCallback toggleObscureText;
  final String? Function(String? p1) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: AppTextFormField(
        controller: controller,
        prefixIcon: Image.asset(
          'assets/icons/password-icon.png',
          scale: 20,
          color: Colors.grey[700],
        ),
        hintText: hintText,
        isObscureText: isObscureText,
        suffixIcon: GestureDetector(
          onTap: toggleObscureText,
          child: Icon(
            isObscureText ? Icons.visibility_off : Icons.visibility,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
