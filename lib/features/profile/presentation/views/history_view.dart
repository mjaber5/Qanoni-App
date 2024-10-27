import 'package:flutter/material.dart';

import 'widgets/history_widgets/history_view_body.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HistoryViewBody(),
    );
  }
}
