import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/utils/constants/colors.dart';
import '../chatbot/presentation/views/chatbot_view.dart';
import '../home/presentation/views/home_view.dart';
import '../notification/presentation/views/notification_view.dart';
import '../profile/presentation/views/profile_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {

  var _currentIndex = 0;
  List screens = const [
    HomeView(),
    ChatbotView(),
    NotificationView(),
    ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.home_24),
            title:  Text(localizations.homeScreen),
            selectedColor: QColors.secondary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.message_text_15),
            title:  Text(localizations.chatbotAppbarTitle),
            selectedColor: QColors.secondary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.notification_bing5),
            title:  Text(localizations.notificationScreen),
            selectedColor: QColors.secondary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title:  Text(localizations.profileScreen),
            selectedColor: QColors.secondary,
          ),
        ],
      ),
    );
  }
}
