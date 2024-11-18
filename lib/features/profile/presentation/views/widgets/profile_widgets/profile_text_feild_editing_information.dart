import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:user_repository/user_reposetory.dart';

import 'custom_label_text_field_profile_view.dart';
import 'custom_text_feild_profile_view.dart';

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
          const SizedBox(height: 12),
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
}
