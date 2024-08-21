import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class ChatbotTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatbotTextField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
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
