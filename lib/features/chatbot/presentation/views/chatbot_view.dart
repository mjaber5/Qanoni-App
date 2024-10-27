import 'package:flutter/material.dart';

import 'widgets/chatbot_view_body.dart';

class ChatbotView extends StatelessWidget {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatbotViewBody(),
    );
  }
}
