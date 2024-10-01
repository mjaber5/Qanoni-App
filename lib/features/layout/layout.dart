import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/utils/constants/colors.dart';
import '../../core/utils/constants/text_strings.dart';
import '../chatbot/presentation/views/chatbot_view.dart';
import '../home/presentation/views/home_view.dart';
import '../notification/presentation/views/notification_view.dart';
import '../profile/presentation/views/profile_view.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
            title: const Text(QTexts.homeAppbarTitle),
            selectedColor: QColors.secondary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.message_text_15),
            title: const Text(QTexts.chatbotAppbarTitle),
            selectedColor: QColors.secondary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.notification_bing5),
            title: const Text(QTexts.notificationAppbarTitle),
            selectedColor: QColors.secondary,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text(QTexts.profileAppbarTitle),
            selectedColor: QColors.secondary,
          ),
        ],
      ),
    );
  }
}
