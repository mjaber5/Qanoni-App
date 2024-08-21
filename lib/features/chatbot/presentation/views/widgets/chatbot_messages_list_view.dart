import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class ChatbotMessagesListView extends StatelessWidget {
  final List<Map<String, dynamic>> _messages;

  const ChatbotMessagesListView({
    super.key,
    required List<Map<String, dynamic>> messages,
  }) : _messages = messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          final isUserMessage = message['isUserMessage'] as bool;

          return Align(
            alignment:
                isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              margin:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: isUserMessage ? TColors.secondary : TColors.darkerGrey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                message['text'] as String,
                style: TextStyle(
                  color: isUserMessage ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
