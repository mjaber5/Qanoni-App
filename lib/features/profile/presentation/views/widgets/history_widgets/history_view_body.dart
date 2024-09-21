import 'package:flutter/material.dart';
import 'package:qanoni/features/profile/presentation/views/widgets/history_widgets/custom_history_app_bar.dart';

class HistoryViewBody extends StatelessWidget {
  const HistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomHistoryAppBar(),
      ],
    );
  }
}
