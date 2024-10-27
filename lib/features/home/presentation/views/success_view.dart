import 'package:flutter/material.dart';

import 'package:qanoni/features/home/presentation/views/success_widgets/success_view_body.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SuccessViewBody(),
    );
  }
}
