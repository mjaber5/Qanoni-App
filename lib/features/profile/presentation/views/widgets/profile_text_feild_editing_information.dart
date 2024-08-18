import 'package:flutter/material.dart';
import 'package:qanoni/constant.dart';
import 'package:qanoni/core/utils/styles.dart';

class ProfileUserInformationEditingField extends StatelessWidget {
  const ProfileUserInformationEditingField({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController birthdayController = TextEditingController();
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
            const Icon(Icons.date_range, color: kWhiteColor),
          ),
          const SizedBox(height: 18),
          labelText('Phone :'),
          const SizedBox(height: 8),
          customTextFeild(
            birthdayController,
            'Enter your phone',
            const Icon(Icons.phone, color: kWhiteColor),
          ),
          const SizedBox(height: 18),
          labelText('Email :'),
          const SizedBox(height: 8),
          customTextFeild(
            birthdayController,
            'Enter your email',
            const Icon(Icons.email, color: kWhiteColor),
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
    TextEditingController birthdayController,
    String hintText,
    Icon prefixIcon,
  ) {
    return TextFormField(
      controller: birthdayController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.5),
        ),
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: kGreyColor.withOpacity(0.6)),
        filled: true,
        fillColor: kWhiteColor.withOpacity(0.1),
      ),
    );
  }
}
