import 'package:flutter/material.dart';
import 'cutsom_privacy_policy_app_bar.dart';
import 'privacy_policy_details_body.dart';
import 'privacy_policy_logo_text.dart';

class PrivacyPolicyBody extends StatelessWidget {
  const PrivacyPolicyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomPrivacyPolicyAppBar(),
        SizedBox(height: 24),
        PrivacyPolicyLogoText(),
        SizedBox(height: 24),
        PrivacyPolicyDetailsBody(),
      ],
    );
  }
}
