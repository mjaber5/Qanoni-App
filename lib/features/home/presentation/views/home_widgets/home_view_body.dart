import 'package:flutter/material.dart';
// import '../contracts/contracts_cards_view.dart';
import 'button_head_home.dart';
import 'custom_home_view_app_bar.dart';
import 'new_btn_home.dart';

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
                  const ButtonHomeView(),
                  // const ContractsCardsView(),
                 const SizedBox(height: 100),

                  const NewBtnHome()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
