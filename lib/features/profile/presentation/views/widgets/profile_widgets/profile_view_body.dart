import 'package:flutter/material.dart';

import 'custom_profile_app_bar.dart';
import 'profile_text_feild_editing_information.dart';
import 'profile_user_information_card.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          AppbarProfilState(),
          ProfileUserInformationCard(),
          ProfileUserInformationEditingField(),
        ],
      ),
    );
  }
}
