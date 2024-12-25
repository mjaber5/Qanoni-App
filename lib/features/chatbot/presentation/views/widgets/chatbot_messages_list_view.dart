import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatbotMessagesListView extends StatelessWidget {
  final List<Map<String, dynamic>> _messages;
  final List<ChatUser> typingUsers;

  const ChatbotMessagesListView({
    super.key,
    required List<Map<String, dynamic>> messages,
    required this.typingUsers, // إضافة الـ typingUsers
  }) : _messages = messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DashChat(
        currentUser: ChatUser(id: '1', firstName: 'User'),
        typingUsers: typingUsers, // هنا تم تمرير قائمة الـ typingUsers
        messageOptions: MessageOptions(
          currentUserContainerColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          currentUserTextColor: Colors.white,
        ),
        messages: _messages.map((message) {
          return ChatMessage(
            text: message['text'],
            user: message['isUserMessage'] 
              ? ChatUser(id: '1', firstName: 'User') 
              : ChatUser(id: 'bot', firstName: 'ChatBot'),
            createdAt: DateTime.now(),
          );
        }).toList(),
        onSend: (ChatMessage m) {
          // Handle message send action here
        },
      ),
    );
  }
}
