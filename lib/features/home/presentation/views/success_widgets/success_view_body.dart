import 'package:flutter/material.dart';
import 'package:qanoni/features/home/presentation/views/success_widgets/success_button.dart';
import 'package:qanoni/features/home/presentation/views/success_widgets/success_icon_view.dart';
import 'package:qanoni/features/home/presentation/views/success_widgets/success_sub_text.dart';
import 'package:qanoni/features/home/presentation/views/success_widgets/success_text.dart';

class SuccessViewBody extends StatelessWidget {
  const SuccessViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SuccessIconView(),
        SuccessText(),
        SuccessSubText(),
        SizedBox(height: 180),
        SuccessButton(),
      ],
    );
  }
}
