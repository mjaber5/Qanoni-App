import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/core/utils/theme/custom_themes/text_field_theme.dart';

class ProfileUserInformationEditingField extends StatelessWidget {
  const ProfileUserInformationEditingField({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController birthdayController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText('Birthday :'),
          const SizedBox(height: 8),
          customTextFeild(
            birthdayController,
            'Enter your birthday',
            const Icon(
              Icons.date_range,
            ),
            TextInputType.datetime,
          ),
          const SizedBox(height: 18),
          labelText('Phone :'),
          const SizedBox(height: 8),
          customTextFeild(
            phoneController,
            'Enter your phone',
            const Icon(
              Icons.phone,
            ),
            TextInputType.number,
          ),
          const SizedBox(height: 18),
          labelText('Email :'),
          const SizedBox(height: 8),
          customTextFeild(
            emailController,
            'Enter your email',
            const Icon(
              Icons.email,
            ),
            TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Text labelText(String text) {
    return Text(
      text,
      style: Styles.textStyle16.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }

  TextFormField customTextFeild(
    TextEditingController controller,
    String hintText,
    Icon prefixIcon,
    TextInputType inputType,
  ) {
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
