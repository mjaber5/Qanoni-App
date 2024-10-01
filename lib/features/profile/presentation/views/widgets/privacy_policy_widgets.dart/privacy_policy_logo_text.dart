import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../core/utils/styles.dart';

class PrivacyPolicyLogoText extends StatelessWidget {
  const PrivacyPolicyLogoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Text(
          QTexts.privacyPolicyAppBarTitle,
          style: Styles.textStyle20.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
