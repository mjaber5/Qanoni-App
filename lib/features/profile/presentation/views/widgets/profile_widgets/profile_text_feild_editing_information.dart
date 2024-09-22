import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/profile_widgets/custom_label_text_field_profile_view.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/profile_widgets/custom_text_feild_profile_view.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/profile_widgets/profile_date_picker.dart';
import 'package:user_repository/user_reposetory.dart';

class ProfileUserInformationEditingField extends StatefulWidget {
  const ProfileUserInformationEditingField({super.key});

  @override
  State<ProfileUserInformationEditingField> createState() =>
      _ProfileUserInformationEditingFieldState();
}

class _ProfileUserInformationEditingFieldState
    extends State<ProfileUserInformationEditingField> {
  late final FirebaseUserRepo _userRepo;
  String? _email;
  String? _phone;
  TextEditingController birthdayController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userRepo = FirebaseUserRepo();
    _loadUserInformation();
  }

  Future<void> _loadUserInformation() async {
    try {
      final currentUser = _userRepo.firebaseAuth.currentUser;
      if (currentUser != null) {
        final userDoc =
            await _userRepo.usersCollection.doc(currentUser.uid).get();

        if (userDoc.exists) {
          setState(() {
            _email = userDoc.data()?['email'] ?? 'Unknown';
            emailController.text = _email!;
            _phone = userDoc.data()?['phone'] ?? 'Unknown';
            phoneController.text = _phone!;
          });
        } else {
          _email = 'Unknown User';
          _phone = 'Unknown User';
        }
      }
    } catch (error) {
      log(error.toString());
      log('Error on fetch email');
    }
  }

  @override
  Widget build(BuildContext context) {
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
