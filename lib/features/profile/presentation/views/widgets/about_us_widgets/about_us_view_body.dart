import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qanoni/core/utils/constants/text_strings.dart';
import 'package:qanoni/core/utils/styles.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/about_us_widgets/about_us_body_text.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/about_us_widgets/about_us_contact_information.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/about_us_widgets/custom_about_us_app_bar.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAboutUsAppBar(),
        const SizedBox(height: 18),
        Text(
          textAlign: TextAlign.center,
          QTexts.appLogoTitle,
          style: Styles.textStyle30.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        const AboutUsBodyText(),
        const ContactIformation(),
      ],
    );
  }
}
