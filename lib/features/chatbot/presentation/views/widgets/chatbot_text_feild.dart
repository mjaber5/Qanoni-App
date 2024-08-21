import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class ChatbotTextField extends StatelessWidget {
  final TextEditingController chatbotMessageController;
  final VoidCallback onSend;

  const ChatbotTextField({
    super.key,
    required this.chatbotMessageController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: chatbotMessageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: QColors.secondary),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: QColors.secondary,
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
