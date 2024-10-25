import 'dart:developer';

import 'package:flutter/material.dart';
import 'custom_label_text_field_profile_view.dart';
import 'custom_text_feild_profile_view.dart';
import 'profile_date_picker.dart';
import 'package:user_repository/user_reposetory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           LabelTextFieldProfileView(text: '${localizations.birthday} :'),
          const SizedBox(height: 8),
          CustomTextFieldProfileView(
              controller: birthdayController,
              hintText: localizations.profileBirthdayHintText,
              prefixIcon: IconButton(
                icon: const Icon(Icons.date_range),
                onPressed: () {
                  showDialogDatePicker(context, birthdayController);
                },
              ),
              inputType: TextInputType.datetime),
          const SizedBox(height: 18),
           LabelTextFieldProfileView(text: '${localizations.phone} :'),
          const SizedBox(height: 8),
          CustomTextFieldProfileView(
              controller: phoneController,
              hintText: localizations.profilePhoneHintText,
              prefixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.phone,
                ),
              ),
              inputType: TextInputType.number),
          const SizedBox(height: 18),
           LabelTextFieldProfileView(text: '${localizations.email} :'),
          const SizedBox(height: 8),
          CustomTextFieldProfileView(
            controller: emailController,
            hintText: localizations.profileEmailHintText,
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
