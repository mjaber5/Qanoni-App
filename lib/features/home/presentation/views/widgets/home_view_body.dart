import 'package:flutter/material.dart';
import 'package:qanoni/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:qanoni/features/home/presentation/views/widgets/services_card_list_view_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomAppBar(),
        ServicesCardListViewItem(),
      ],
    );
  }
}
