import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/profile_widgets/custom_label_text_field_profile_view.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/profile_widgets/custom_text_feild_profile_view.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/profile_widgets/profile_date_picker.dart';

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
          const LabelTextFieldProfileView(text: '${QTexts.birthday} :'),
          const SizedBox(height: 8),
          CustomTextFieldProfileView(
              controller: birthdayController,
              hintText: QTexts.profileBirthdayHintText,
              prefixIcon: IconButton(
                icon: const Icon(Icons.date_range),
                onPressed: () {
                  showDialogDatePicker(context, birthdayController);
                },
              ),
              inputType: TextInputType.datetime),
          const SizedBox(height: 18),
          const LabelTextFieldProfileView(text: '${QTexts.phone} :'),
          const SizedBox(height: 8),
          CustomTextFieldProfileView(
              controller: phoneController,
              hintText: QTexts.profilePhoneHintText,
              prefixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.phone,
                ),
              ),
              inputType: TextInputType.number),
          const SizedBox(height: 18),
          const LabelTextFieldProfileView(text: '${QTexts.email} :'),
          const SizedBox(height: 8),
          CustomTextFieldProfileView(
            controller: emailController,
            hintText: QTexts.profileEmailHintText,
            prefixIcon: IconButton(
              icon: const Icon(
                Icons.email,
              ),
              onPressed: () {},
            ),
            inputType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Future<dynamic> showDialogDatePicker(
      BuildContext context, TextEditingController birthdayController) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SizedBox(
              height: 500,
              width: 400,
              child: ProfileDatePicker(
                controller: birthdayController,
              ),
            ),
          ),
        );
      },
    );
  }
}
