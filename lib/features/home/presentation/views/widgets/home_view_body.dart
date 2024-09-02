import 'package:flutter/material.dart';
import 'package:qanoni/features/home/presentation/views/widgets/custom_home_view_app_bar.dart';
import 'package:qanoni/features/home/presentation/views/widgets/services_card_list_view_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomAppBar(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // const ButtonHomeView(),
                  const ServicesCardListViewItem(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
