import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';

class SignupTextFeilds extends StatelessWidget {
  const SignupTextFeilds({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: QTexts.signupUsernameTextFeildHint,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: QTexts.signupPhoneNumberTextFeildHint,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: QTexts.signupEmailTextFeildHint,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: QTexts.signupPasswordTextFeildHint,
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: QTexts.signupConfirmPasswordTextFeildHint,
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
