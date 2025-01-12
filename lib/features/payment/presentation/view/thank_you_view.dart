import 'package:flutter/material.dart';
import 'package:qanoni/core/widgets/create_contract_app_bar.dart';
import 'package:qanoni/features/payment/presentation/view/widget/thank_you_view_body.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Transform.translate(
        offset: const Offset(0, -18),
        child: const ThankYouViewBody(),
      ),
    );
  }
}
