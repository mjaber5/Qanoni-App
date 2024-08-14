import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/styles.dart';

class ChatbotViewBody extends StatelessWidget {
  const ChatbotViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'ChatBot',
          style: Styles.textStyle20,
        ),
      ),
    );
  }
}
