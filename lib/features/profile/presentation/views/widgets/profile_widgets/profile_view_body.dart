import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/colors.dart';
import 'custom_profile_app_bar.dart';
import 'profile_text_feild_editing_information.dart';
import 'profile_user_information_card.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppbarProfilState(),
        const ProfileUserInformationCard(),
        DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabs: const [
                  Tab(text: "My property"),
                  Tab(text: "My information"),
                  Tab(text: "My contracts"),
                ],
                labelColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: QColors.secondary,
              ),
              const SizedBox(
                height: 300,
                child: TabBarView(
                  children: [
                    Center(child: Text("Content for Tab 1")),
                    ProfileUserInformationEditingField(),
                    Center(child: Text("Content for Tab 3")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
