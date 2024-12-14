import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'about_us_body_text.dart';
import 'about_us_contact_information.dart';
import 'custom_about_us_app_bar.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAboutUsAppBar(),
        const SizedBox(height: 16),
        const AboutUsBodyText(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
        ),
        const ContactIformation(),
      ],
    );
  }
}
