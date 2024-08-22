import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/custom_label_text_field_profile_view.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/custom_text_feild_profile_view.dart';

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
          const LabelTextFieldProfileView(text: '${QTexts.birthday} : '),
          const SizedBox(height: 8),
          CustomTextFieldProfileView(
              controller: birthdayController,
              hintText: 'Enter your birthday',
              prefixIcon: const Icon(
                Icons.date_range,
              ),
              inputType: TextInputType.datetime),
          const SizedBox(height: 18),
          const LabelTextFieldProfileView(text: '${QTexts.phone} : '),
          const SizedBox(height: 8),
          CustomTextFieldProfileView(
              controller: phoneController,
              hintText: 'Enter your phone',
              prefixIcon: const Icon(
                Icons.phone,
              ),
              inputType: TextInputType.number),
          const SizedBox(height: 18),
          const LabelTextFieldProfileView(text: '${QTexts.email} : '),
          const SizedBox(height: 8),
          CustomTextFieldProfileView(
              controller: emailController,
              hintText: 'Enter your email',
              prefixIcon: const Icon(
                Icons.email,
              ),
              inputType: TextInputType.emailAddress),
        ],
      ),
    );
  }
}
