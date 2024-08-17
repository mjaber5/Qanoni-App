import 'package:flutter/material.dart';
import 'package:qanoni/features/chatbot/presentation/views/widgets/chatbot_messages_list_view.dart';
import 'package:qanoni/features/chatbot/presentation/views/widgets/chatbot_text_feild.dart';
import 'package:qanoni/features/chatbot/presentation/views/widgets/custom_app_bar.dart';

class ChatbotViewBody extends StatefulWidget {
  const ChatbotViewBody({super.key});

  @override
  ChatbotViewBodyState createState() => ChatbotViewBodyState();
}

class ChatbotViewBodyState extends State<ChatbotViewBody> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, {'text': text, 'isUserMessage': true});
        _controller.clear();

        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _messages.insert(
                0, {'text': 'Bot response to "$text"', 'isUserMessage': false});
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(),
        ChatbotMessagesListView(messages: _messages),
        ChatbotTextField(
          controller: _controller,
          onSend: _handleSend,
        ),
      ],
    );
  }
}
