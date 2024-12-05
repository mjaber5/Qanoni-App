import 'package:flutter/material.dart';
import 'package:qanoni/core/widgets/app_custom_app_bar.dart';
import 'package:qanoni/features/home/presentation/views/home_widgets/btn_darft.dart';
import 'package:qanoni/features/home/presentation/views/home_widgets/hi_user_text.dart';
import 'button_head_home.dart';
import 'new_btn_home.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: buildCustomAppBar(),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const HiUserText(),
                  const ButtonHomeView(),
                  const SizedBox(height: 100),
                  const NewBtnHome(),
                  const SizedBox(height: 10),
                  const BtnDarft()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
